# Cloud Formation boostrap code for workload projects

This Cloud Formation template creates the resources to allow the Image Factory CodePipeline to create the needed resources. In a multi-account
setup, this has to be run in the so called `workload` projects, i.e., where the images are created.

In particular, the following resources are created

* a role to be assumed by Terragrunt
* a policy for the above role (it could also be embedded into the role)
* (optional) an OIDC provider to authenitcate the GitHub tokens

The role should allow the creation of the resources described by the Terragrunt code executed by the Image Factory pipeline.

Please note that the role being created needs to trust a role in another account, nemely the one used by the Image Factory
CodePipeline to create resources (hence the policy should be rather permissive).

### How to deploy the template

The assumption is that the template is copied to a bucket.

```bash
aws cloudformation update-stack \
--stack-name <stack name> \
--template-url <S3 URL of the template file> \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=<environment name> \
ParameterKey=TerragruntTrustedArns,ParameterValue=<ARN(s) of the role(s) in the Image Factory pipeline project, to be trusted by the deployer> \
ParameterKey=ResourcePrefix,ParameterValue=<prefix for the resource names>
```

For example,

```bash
aws cloudformation create-stack \
--stack-name test-ml-imagefactory-workload \
--template-url https://test-ml-source-code.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=dev \
ParameterKey=TerragruntTrustedArns,ParameterValue="arn:aws:iam::446161183143:role/test-ml-if-codebuild\,arn:aws:iam::446161183143:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AdministratorAccess_a3901694f1eb0d28" \
ParameterKey=ResourcePrefix,ParameterValue=test-ml
```

Please note the usage of `--capabilities CAPABILITY_NAMED_IAM`: it's needed since the template is creating named IAM resources (role, policy).

### Deployment notes

#### Audi development account

In order to connect the AWS CLI to the right account, be sure that `awsume` has been configured as per the onboarding documentation. The file `~/.aws/config` should contain the following entries

```bash
...
[profile acs-prd-federated]
role_arn = arn:aws:iam::570331475571:role/acs/acs-admin
principal_arn = arn:aws:iam::570331475571:saml-provider/live_AUDIAG-Internet
awsume_saml_endpoint = https://idp-sso1.audi.de/isam/sps/live-www-StrongMulti-02-audiIDP/saml20/logininitial?RequestBinding=HTTPPost&PartnerId=urn:amazon:webservices
awsume_saml_custom_input_login-form-type = token
awsume_saml_username = <your username>
awsume_saml_password = <your PIN>{mfa_token}
...
[profile acs-imagefactory2-dev]
role_arn=arn:aws:iam::969285305301:role/acs/acs-iam-prd-deployment-role
source_profile=acs-prd-mfa
```

If everything is correct, enter the following commands

```bash
awsume acs-prd-federated --with-saml -o acs-prd-mfa --mfa-token <a 6 digit token from your RSA key>
awsume acs-imagefactory2-dev
```

**Account ID**: `969285305301`

**Bucket ID**: `if2-dev-cloudformation-input-eu-central-1-969285305301` (manually created)

**Region**: `eu-central-1`

**Important check**: The command `aws sts get-caller-dentity` should show an ARN like `arn:aws:sts::969285305301:assumed-role/acs-iam-prd-deployment-role/acs-imagefactory2-dev` (where `acs-imagefactory2-dev` is the name of the profile)

**Command**:

Bootstrap, with only the local assumed role (just to create the role defined in the stack)

```bash
aws cloudformation create-stack \
--stack-name if2-dev-workload \
--region eu-central-1 \
--template-url https://if2-dev-cloudformation-input-eu-central-1-969285305301.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=Development \
ParameterKey=TerragruntTrustedArns,ParameterValue="arn:aws:iam::969285305301:role/acs/acs-iam-prd-deployment-role\,arn:aws:sts::720257828372:assumed-role/acs-iam-prd-deployment-role/acs-prd-deploy\,arn:aws:iam::720257828372:role/if2-pipeline-terraform-eu-central-1-720257828372" \
ParameterKey=ResourcePrefix,ParameterValue=if2-dev
```

The role `arn:aws:iam::720257828372:role/if2-pipeline-terraform-eu-central-1-720257828372` is in the list because the Terraform code is also creating some resources in the workload account(s), namely the blueprints buckets. The GitHub workflow uses the ImageFactory role previously mentioned (i.e., the role used by Terraform to create the pipeline handling ImageFactory itself), which, in turn, has to be able to assume the role in the development account to manage in this environment.

Once the CodePipeline has been created in the tooling account, the related CodeBuild role has to be added to the trust policy of the role created by the stack

```bash
aws cloudformation update-stack \
--stack-name if2-dev-workload \
--region eu-central-1 \
--template-url https://if2-dev-cloudformation-input-eu-central-1-969285305301.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=Development \
ParameterKey=TerragruntTrustedArns,ParameterValue="arn:aws:iam::969285305301:role/acs/acs-iam-prd-deployment-role\,arn:aws:sts::720257828372:assumed-role/acs-iam-prd-deployment-role/acs-prd-deploy\,arn:aws:iam::720257828372:role/if2-pipeline-terraform-eu-central-1-720257828372\,arn:aws:iam::720257828372:role/if2-codebuild" \
ParameterKey=ResourcePrefix,ParameterValue=if2-dev \
ParameterKey=GitHubTokensOIDCProviderCreate,ParameterValue=true
```
Please note that the `ParameterKey=GitHubTokensOIDCProviderCreate` has been added because the OIDC provider to validate the GitHub tokens is missing. It's needed at least to run the GitHub workflow to build the frontend image.

#### Audi production account

In order to connect the AWS CLI to the right account, be sure that `awsume` has been configured as per the onboarding documentation. The file `~/.aws/config` should contain the following entries

```bash
...
[profile acs-prd-federated]
role_arn = arn:aws:iam::570331475571:role/acs/acs-admin
principal_arn = arn:aws:iam::570331475571:saml-provider/live_AUDIAG-Internet
awsume_saml_endpoint = https://idp-sso1.audi.de/isam/sps/live-www-StrongMulti-02-audiIDP/saml20/logininitial?RequestBinding=HTTPPost&PartnerId=urn:amazon:webservices
awsume_saml_custom_input_login-form-type = token
awsume_saml_username = <your username>
awsume_saml_password = <your PIN>{mfa_token}
...
[profile acs-imagefactory2-prd]
role_arn=arn:aws:iam::879919243408:role/acs/acs-iam-prd-deployment-role
source_profile=acs-prd-mfa
```

If everything is correct, enter the following commands

```bash
awsume acs-prd-federated --with-saml -o acs-prd-mfa --mfa-token <a 6 digit token from your RSA key>
awsume acs-imagefactory2-prd
```

**Account ID**: `879919243408`

**Bucket ID**: `if2-prod-cloudformation-input-eu-central-1-879919243408` (manually created)

**Region**: `eu-central-1`

**Important check**: The command `aws sts get-caller-dentity` should show an ARN like `arn:aws:sts::879919243408:assumed-role/acs-iam-prd-deployment-role/acs-imagefactory2-prd` (where `acs-imagefactory2-prd` is the name of the profile)

**Command**:

Bootstrap, with only the local assumed role (just to create the role defined in the stack)

```bash
aws cloudformation create-stack \
--stack-name if2-prod-workload \
--region eu-central-1 \
--template-url https://if2-prod-cloudformation-input-eu-central-1-879919243408.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=Production \
ParameterKey=TerragruntTrustedArns,ParameterValue="arn:aws:iam::879919243408:role/acs/acs-iam-prd-deployment-role\,arn:aws:sts::720257828372:assumed-role/acs-iam-prd-deployment-role/acs-prd-deploy\,arn:aws:iam::720257828372:role/if2-pipeline-terraform-eu-central-1-720257828372" \
ParameterKey=ResourcePrefix,ParameterValue=if2-prd
```

The role `arn:aws:iam::720257828372:role/if2-pipeline-terraform-eu-central-1-720257828372` is in the list because the Terraform code is also creating some resources in the workload account(s), namely the blueprints buckets. The GitHub workflow uses the ImageFactory role previously mentioned (i.e., the role used by Terraform to create the pipeline handling ImageFactory itself), which, in turn, has to be able to assume the role in the development account to manage in this environment.

Once the CodePipeline has been created in the tooling account, the related CodeBuild role has to be added to the trust policy of the role created by the stack

```bash
aws cloudformation update-stack \
--stack-name if2-prod-workload \
--region eu-central-1 \
--template-url https://if2-prod-cloudformation-input-eu-central-1-879919243408.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=Production \
ParameterKey=TerragruntTrustedArns,ParameterValue="arn:aws:iam::879919243408:role/acs/acs-iam-prd-deployment-role\,arn:aws:sts::720257828372:assumed-role/acs-iam-prd-deployment-role/acs-prd-deploy\,arn:aws:iam::720257828372:role/if2-pipeline-terraform-eu-central-1-720257828372\,arn:aws:iam::720257828372:role/if2-codebuild" \
ParameterKey=ResourcePrefix,ParameterValue=if2-prd \
ParameterKey=GitHubTokensOIDCProviderCreate,ParameterValue=true
```

Please note that the `ParameterKey=GitHubTokensOIDCProviderCreate` has been added because the OIDC provider to validate the GitHub tokens is missing. It's needed at least to run the GitHub workflow to build the frontend image.