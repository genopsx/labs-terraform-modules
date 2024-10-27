# system_charts

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert-manager"></a> [cert-manager](#module\_cert-manager) | ./certificate_manager | n/a |
| <a name="module_external-dns"></a> [external-dns](#module\_external-dns) | ./gke_external_dns | n/a |
| <a name="module_kong"></a> [kong](#module\_kong) | ./kong_ingress_controller | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Whether to install cert-manager | `bool` | `false` | no |
| <a name="input_cert_manager_helm_chart_version"></a> [cert\_manager\_helm\_chart\_version](#input\_cert\_manager\_helm\_chart\_version) | The chart version to install cert-manager | `string` | `"v1.11.0"` | no |
| <a name="input_cert_manager_issuer_email"></a> [cert\_manager\_issuer\_email](#input\_cert\_manager\_issuer\_email) | The email to use for the cert-manager issuer | `string` | `""` | no |
| <a name="input_cert_manager_issuer_staging_mode"></a> [cert\_manager\_issuer\_staging\_mode](#input\_cert\_manager\_issuer\_staging\_mode) | Whether to install cert-manager in staging mode | `bool` | `true` | no |
| <a name="input_cert_manager_namespace"></a> [cert\_manager\_namespace](#input\_cert\_manager\_namespace) | The namespace to install cert-manager | `string` | `"cert-manager"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_external_dns_chart_name"></a> [external\_dns\_chart\_name](#input\_external\_dns\_chart\_name) | The chart name to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_external_dns_chart_version"></a> [external\_dns\_chart\_version](#input\_external\_dns\_chart\_version) | The chart version to install external-dns | `string` | `"1.12.0"` | no |
| <a name="input_external_dns_domain_filter"></a> [external\_dns\_domain\_filter](#input\_external\_dns\_domain\_filter) | The domain filter to install external-dns | `string` | `"Just a place holder to make this param Optional"` | no |
| <a name="input_external_dns_extra_values"></a> [external\_dns\_extra\_values](#input\_external\_dns\_extra\_values) | Extra values to pass to the chart | `map(string)` | `{}` | no |
| <a name="input_external_dns_namespace"></a> [external\_dns\_namespace](#input\_external\_dns\_namespace) | The namespace to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_external_dns_service_account_name"></a> [external\_dns\_service\_account\_name](#input\_external\_dns\_service\_account\_name) | The service account name to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_gke_external_dns_enabled"></a> [gke\_external\_dns\_enabled](#input\_gke\_external\_dns\_enabled) | Whether to install external-dns for gke | `bool` | `false` | no |
| <a name="input_kong_enabled"></a> [kong\_enabled](#input\_kong\_enabled) | Whether to install kong | `bool` | `false` | no |
| <a name="input_kong_extra_values"></a> [kong\_extra\_values](#input\_kong\_extra\_values) | Extra values to pass to the chart | `map(string)` | `{}` | no |
| <a name="input_kong_namespace"></a> [kong\_namespace](#input\_kong\_namespace) | The namespace to install kong | `string` | `"kong"` | no |
| <a name="input_kong_version"></a> [kong\_version](#input\_kong\_version) | The version to install kong | `string` | `"2.26.3"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | `"Default value for AWS - to make this param Optional"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to host the cluster in | `string` | `"Default value for GCP - to make this param Optional"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
