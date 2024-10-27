# ecr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.70 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.default_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_days_to_remove_untagged_images"></a> [days\_to\_remove\_untagged\_images](#input\_days\_to\_remove\_untagged\_images) | days to remove untagged images | `number` | `3` | no |
| <a name="input_max_image_count"></a> [max\_image\_count](#input\_max\_image\_count) | days to remove untagged images | `number` | `50` | no |
| <a name="input_pr_image_count"></a> [pr\_image\_count](#input\_pr\_image\_count) | days to remove pull-request images | `number` | `7` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | Repositories list | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repositories_arns"></a> [repositories\_arns](#output\_repositories\_arns) | n/a |
| <a name="output_repositories_urls"></a> [repositories\_urls](#output\_repositories\_urls) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
