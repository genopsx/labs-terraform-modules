# github-webhook-to-s3

## Introduction

This module creates

* a webhook in a GitHub project, so that events related to the configured repo can trigger CodeBuild. The documentation is available [here](https://docs.aws.amazon.com/codebuild/latest/userguide/github-webhook.html) and the related Terraform resource is [aws\_codebuild\_webhook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook).
* a CodeBuild project which archives the repo's branch that triggered the action and it copies it to a bucket (externally created).

The advantages are:

* no need to maintain the secret token, shared between the AWS infrastructure and the GitHub project's webhook configuration
* no need for a token or a SSH key to pull the code. When CodeBuild is triggered, at runtime the repo's content is checked out into the current working folder.

The disadvantages are:

* before Terraform (i.e., AWS in the background) is able to create the webhook, the CodeBuild's project `Source` section should be connected to GitHub. This is only possible via the AWS Console.

## Initial setup

As already mentioned, a human operator with enough privileges on both the AWS Console and the GitHub repo and / or organisation where the source repo resides, has to authorise the application.

Assuming that everything is started from scratch, hence the CodeBuild project nor the webhook exist, here's the procedure:

* in the Terraform repo, where configuring this module, set the variable `create_github_webhook` to `false`. If there's no connection between CodeBuild and GitHub, the creation of the webhook fails, since the secret token is missing (it's generated autmatically)
* run Terraform and check that the CodeBuild project has been created
* connect to the AWS Console, open the CodeBuild project, edit the source and click on the `Connect to GitHub` button
* a new window opens and a redirection to GitHub takes place, in order to ask for the authorize the account and the organisation. Please provide access to the organisation as well, if the target repo belongs to it
* the same detached window should now point back to AWS and, asking for a final confirmation on the AWS side
* don't forget to save the changes, clicking on the `Update source` button at the bottom of the CodeBuild source editor view
* remove the variable `create_github_webhook` from the code instantiating the module (see the first point) and run Terraform. A resource of type `aws_codebuild_webhook` should now be created
* please refer to [this](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-github-pull-request.html#verification-checks) section for a final check. In short
	*	if editing again the CodeBuild project's source, a button `Disconnect from GitHub` should appear
	* on GitHub
		* in the user's settings, clicking on `Integrations` -> `Applications` (on the left) and then on the tab `Authorized OAuth Apps`, `AWS CodeBuild (<AWS region>)`, (i.e., `AWS CodeBuild (Frankfurt)`) should appear
		* in the repository that has been targeted by the variable `git_repo`, under `Settings` (on top) and then `Webhooks` (on the left), an entry that looks like `https://codebuild.eu-central-1.amazonaws.com/webhooks?t=...` should be listed
		* in the organization's settings (if applicable), clicking `Third-party Access` -> `OAuth application policy` (on the left) should show `AWS CodeBuild (<AWS region>)`, (i.e., `AWS CodeBuild (Frankfurt)`) as `Approved`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.git2s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_webhook.github_fetch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |
| [aws_iam_policy.codebuild_git2s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_git2s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_git2s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.codebuild_git2s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_git2s3_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_security_group.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_compute_type"></a> [build\_compute\_type](#input\_build\_compute\_type) | Compute type to use for the CodeBuild resource. | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_build_image"></a> [build\_image](#input\_build\_image) | Image to use for the CodeBuild resource | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:3.0"` | no |
| <a name="input_codebuild_cloudwatch_group_name"></a> [codebuild\_cloudwatch\_group\_name](#input\_codebuild\_cloudwatch\_group\_name) | The group name to identify CloudBuild's CloudWatch logs | `string` | `null` | no |
| <a name="input_codebuild_vpc_id"></a> [codebuild\_vpc\_id](#input\_codebuild\_vpc\_id) | The VPC used for the CodeBuild projects | `string` | n/a | yes |
| <a name="input_create_github_webhook"></a> [create\_github\_webhook](#input\_create\_github\_webhook) | Whether to create the GitHub webhook or not | `bool` | `true` | no |
| <a name="input_deployment_branches"></a> [deployment\_branches](#input\_deployment\_branches) | List of branches that should be deployed | `list(string)` | <pre>[<br>  "main"<br>]</pre> | no |
| <a name="input_deployment_file_name"></a> [deployment\_file\_name](#input\_deployment\_file\_name) | The file name of the archive created out of the branches that will be deployed. Please note that the '.zip' extension will be added | `string` | `"deployment"` | no |
| <a name="input_git_repo"></a> [git\_repo](#input\_git\_repo) | The GitHub repo, usually in the form <organisation>/<repo name> | `string` | n/a | yes |
| <a name="input_include_git_metadata"></a> [include\_git\_metadata](#input\_include\_git\_metadata) | Include the .git folder in the archive | `bool` | `false` | no |
| <a name="input_merge_requests_file_name"></a> [merge\_requests\_file\_name](#input\_merge\_requests\_file\_name) | The file name of the archive created out of the branches that will be only tested (run up to the plan phase). Please note that the '.zip' extension will be added | `string` | `"planonly"` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to use to name resources | `string` | `"image-factory"` | no |
| <a name="input_source_code_bucket_arn"></a> [source\_code\_bucket\_arn](#input\_source\_code\_bucket\_arn) | The ARN of bucket that hosts the source code (created externally) | `string` | n/a | yes |
| <a name="input_source_code_bucket_kms_key_arn"></a> [source\_code\_bucket\_kms\_key\_arn](#input\_source\_code\_bucket\_kms\_key\_arn) | The ARN of the KMS key to decrypt the bucket that hosts the source code (created externally) | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_as_pipeline_trigger"></a> [use\_as\_pipeline\_trigger](#input\_use\_as\_pipeline\_trigger) | Whether to copy the repo content to a location that triggers a pipeline or store it using the tag (branch) name. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_role_name"></a> [codebuild\_role\_name](#output\_codebuild\_role\_name) | The name of the CodeBuild role |
<!-- END_TF_DOCS -->