# apache_airflow

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.airflow](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM Certificate ARN | `string` | `""` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Helm chart to release | `string` | `"1.15.0"` | no |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | List of subnet IDs | `list(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Roure53 hosted zone name | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of release | `string` | `"airflow"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name to deploy helm release | `string` | `"default"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of subnet IDs | `list(string)` | n/a | yes |
| <a name="input_serviceaccount"></a> [serviceaccount](#input\_serviceaccount) | Serviceaccount name to use within the chart | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Selected AWS Account ID |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_region"></a> [region](#output\_region) | Details about selected AWS region |
<!-- END_TF_DOCS -->
