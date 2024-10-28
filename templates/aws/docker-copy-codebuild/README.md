# docker-copy-codebuild

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.image-builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecr_pull](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.secrets_manager_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_pull](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secrets_manager_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_ecr_repository_kms_arn"></a> [build\_ecr\_repository\_kms\_arn](#input\_build\_ecr\_repository\_kms\_arn) | The ARN of the KMS key used by the build ECR repository | `string` | n/a | yes |
| <a name="input_build_ecr_repository_name"></a> [build\_ecr\_repository\_name](#input\_build\_ecr\_repository\_name) | The name of the ECR repository to fetch the image from | `string` | n/a | yes |
| <a name="input_codebuild_build_timeout"></a> [codebuild\_build\_timeout](#input\_codebuild\_build\_timeout) | Default value for CodeBuild build timeout in minutes | `number` | `45` | no |
| <a name="input_codebuild_project_name"></a> [codebuild\_project\_name](#input\_codebuild\_project\_name) | The name of the CodeBuild project | `string` | n/a | yes |
| <a name="input_codebuild_secrets_manager_access"></a> [codebuild\_secrets\_manager\_access](#input\_codebuild\_secrets\_manager\_access) | The list of secrets that will be used by CodeBuild | <pre>list(object({<br>    name          = string<br>    alias         = string<br>    key           = optional(string)<br>    version_stage = optional(string)<br>    version_id    = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_log_group"></a> [log\_group](#input\_log\_group) | The name of the CloudWatch log group | `string` | n/a | yes |
| <a name="input_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#input\_vpc\_default\_security\_group\_id) | The default security group ID | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |
| <a name="input_vpc_private_subnet_arns"></a> [vpc\_private\_subnet\_arns](#input\_vpc\_private\_subnet\_arns) | The private subnet ARNs | `list(string)` | n/a | yes |
| <a name="input_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#input\_vpc\_private\_subnet\_ids) | The private subnet IDs | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_iam_role_arn"></a> [codebuild\_iam\_role\_arn](#output\_codebuild\_iam\_role\_arn) | n/a |
| <a name="output_codebuild_project_arn"></a> [codebuild\_project\_arn](#output\_codebuild\_project\_arn) | n/a |
<!-- END_TF_DOCS -->
