# Cloud Formation boostrap code

This Cloud Formation template creates the resources to manage the state of the Terraform code deploying the Image Factory pipeline. In a
multi-account setup, this Cloud Formation template is hosted on a support account, only managing the pipeline without hosting any
Image Factory resource.

In particular, the following resources are created

* a bucket for the state (with versioning enabled)
* a KMS key for the bucket encryption
* a DynamoDB table for the locking mechanism
* a role to be assumed by Terraform
* a policy for the above role
* an optional OIDC provider to authenticate the GitHub workflows tokens

The role should allow the creation of the resources needed for the Image Factory pipeline, i.e., among others, the CodePipeline, CodeBuild projects, buckets, API gateways, Lambda functions, IAM objects ...

#### Notes about GitHub workflows

The test and the deployment of the code is carried out by GitHub workflows. The idea is to

* run all steps, **except for** the ones related to deployment, for all PRs targeting `main`
* run all steps, **including** the ones realted to the deployment for PRs merged into main (i.e., `push` events to `main`. Of course there should be rules to protect the branch from direct commits)

GitHub tokens are used for authentication, hence an OIDC provider should be configured:

  * if already present (only one per AWS account is needed), please **specify its ARN** in the parameter `OIDCProviderArn`
  * if it needs to be created, please **do not specify** the parameter `OIDCProviderArn`. In this case it's also a good practice to specify the thumbprints of the certificate, via the parameter `OIDCProviderThumbprintList`. It has a default value, since CloudFormation expects such a list when creating the OIDC provider

The usage of GitHub workflow also implies that the token used can assume the role defined in the template. The trust policy allows a federated principal, with a couple of conditions. One is on the audience, which usually doesn't change (in fact, the parameter `OIDCAudience` has a default value). The second one is on the repo's branches. In this case:

* the GitHub organisation and the repo name **have** to be specified (see the parameters `{GitHubOrg` and `RepositoryName`)
* we don't limit the branch name (i.e., we use the `*` wildcard) since we want to test every PR

### How to deploy the template

The assumption is that the template is copied to a bucket.

```bash
aws cloudformation update-stack \
--stack-name <stack name> \
--template-url <S3 URL of the template file> --capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=<environment name> \
ParameterKey=TerraformTrustedArns,ParameterValue=<comma separated list of ARNs for the Terraform role trust policy> \
ParameterKey=ResourcePrefix,ParameterValue=<prefix for the resource names> \
ParameterKey=GiHubOrg,ParameterValue=<GitHub organisation> \
ParameterKey=RepositoryName,ParameterValue=<GitHub repository>
```

For example,

```bash
aws cloudformation create-stack \
--stack-name test-ml-imagefactory-pipeline \
--template-url https://test-ml-imagefactory-cloudformation-input.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=dev \
ParameterKey=TerraformTrustedArns,ParameterValue=arn:aws:iam::446161183143:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AdministratorAccess_a3901694f1eb0d28 \
ParameterKey=ResourcePrefix,ParameterValue=test-ml-if-pipeline \
ParameterKey=GiHubOrg,ParameterValue=acmex51 \
ParameterKey=RepositoryName,ParameterValue=terraform-modules
```

Please note the usage of `--capabilities CAPABILITY_NAMED_IAM`: it's needed since the template is creating named IAM resources (role, policy).

### Deployment notes

#### Audi tooling account

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
[profile acs-prd-deploy]
role_arn=arn:aws:iam::720257828372:role/acs/acs-iam-prd-deployment-role
source_profile=acs-prd-mfa
```

If everything is correct, enter the following commands

```bash
awsume acs-prd-federated --with-saml -o acs-prd-mfa --mfa-token <a 6 digit token from your RSA key>
awsume acs-prd-deploy
```

**Account ID**: `720257828372`

**Bucket ID**: `if2-pipeline-cloudformation-input-eu-central-1-720257828372` (manually created)

**Region**: `eu-central-1`

**Command**:

```bash
aws cloudformation create-stack \
--stack-name if2-pipeline \
--region eu-central-1 \
--template-url https://if2-pipeline-cloudformation-input-eu-central-1-720257828372.s3.eu-central-1.amazonaws.com/imagefactory.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=Environment,ParameterValue=Production \
ParameterKey=TerraformTrustedArns,ParameterValue=arn:aws:iam::720257828372:role/acs/acs-iam-prd-deployment-role \
ParameterKey=ResourcePrefix,ParameterValue=if2-pipeline \
ParameterKey=GitHubOrg,ParameterValue=audi-acs \
ParameterKey=RepositoryName,ParameterValue=acs-image-factory-iac-pipeline \
ParameterKey=OIDCProviderArn,ParameterValue=arn:aws:iam::720257828372:oidc-provider/token.actions.githubusercontent.com
```

Please note the presence of the `OIDCPoviderArn` parameter, since an OIDC provider for the GitHub token is already present.
