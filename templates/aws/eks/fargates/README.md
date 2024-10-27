# fargate

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fargate_profile"></a> [fargate\_profile](#module\_fargate\_profile) | terraform-aws-modules/eks/aws//modules/fargate-profile | 20.8.5 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name. | `string` | n/a | yes |
| <a name="input_create_fargate_profile"></a> [create\_fargate\_profile](#input\_create\_fargate\_profile) | Whether to create a Fargate Profile. | `bool` | n/a | yes |
| <a name="input_fargate_profile_additional_policies"></a> [fargate\_profile\_additional\_policies](#input\_fargate\_profile\_additional\_policies) | Additional policies to be added to the IAM role. | `map(string)` | n/a | yes |
| <a name="input_fargate_profile_iam_role_name"></a> [fargate\_profile\_iam\_role\_name](#input\_fargate\_profile\_iam\_role\_name) | Name of the IAM role for the Fargate Profile. | `string` | n/a | yes |
| <a name="input_fargate_profile_name"></a> [fargate\_profile\_name](#input\_fargate\_profile\_name) | Name of the Fargate Profile. | `string` | n/a | yes |
| <a name="input_fargate_profile_namespace"></a> [fargate\_profile\_namespace](#input\_fargate\_profile\_namespace) | Namespace to be used by the Fargate Profile. | `string` | n/a | yes |
| <a name="input_fargate_profile_selectors"></a> [fargate\_profile\_selectors](#input\_fargate\_profile\_selectors) | The selectors for the Fargate profile. | <pre>list(object({<br>    namespace = string<br>    labels    = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs to launch Fargate Profiles in. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags for the resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fargate_profile_arn"></a> [fargate\_profile\_arn](#output\_fargate\_profile\_arn) | The Amazon Resource Name (ARN) of the Fargate Profile |
| <a name="output_fargate_profile_id"></a> [fargate\_profile\_id](#output\_fargate\_profile\_id) | The ID of the Fargate Profile |
| <a name="output_fargate_profile_name"></a> [fargate\_profile\_name](#output\_fargate\_profile\_name) | The name of the Fargate Profile |
| <a name="output_fargate_profile_pod_execution_role_arn"></a> [fargate\_profile\_pod\_execution\_role\_arn](#output\_fargate\_profile\_pod\_execution\_role\_arn) | The Amazon Resource Name (ARN) of the pod execution role |
<!-- END_TF_DOCS -->
