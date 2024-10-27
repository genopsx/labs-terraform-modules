# gke_external_dns

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.5.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.external_dns_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.external_dns_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.external_dns_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [helm_release.external_dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to use for the chart | `string` | n/a | yes |
| <a name="input_external_dns_version"></a> [external\_dns\_version](#input\_external\_dns\_version) | The version of the chart | `string` | `"1.12.0"` | no |
| <a name="input_extra_values"></a> [extra\_values](#input\_extra\_values) | Extra values to pass to the chart | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the chart | `string` | `"external-dns"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the chart | `string` | `"kube-system"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_serviceaccount"></a> [serviceaccount](#input\_serviceaccount) | The service account to use for the chart | `string` | `"external-dns"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
