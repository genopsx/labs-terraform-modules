# gke

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns-public-zone"></a> [dns-public-zone](#module\_dns-public-zone) | terraform-google-modules/cloud-dns/google | 5.3.0 |
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google | 33.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_dns_record_set.zone_subzone_ns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Whether to install cert-manager | `bool` | `false` | no |
| <a name="input_cert_manager_issuer_email"></a> [cert\_manager\_issuer\_email](#input\_cert\_manager\_issuer\_email) | The email to use for the cert-manager issuer | `string` | `""` | no |
| <a name="input_cert_manager_issuer_staging_mode"></a> [cert\_manager\_issuer\_staging\_mode](#input\_cert\_manager\_issuer\_staging\_mode) | Whether to install cert-manager in staging mode | `bool` | `true` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | `"wf-1"` | no |
| <a name="input_cluster_parent_hosted_zone"></a> [cluster\_parent\_hosted\_zone](#input\_cluster\_parent\_hosted\_zone) | The parent hosted zone of the cluster -  the . char will be added in the code | `string` | `"dev.assafushy.com"` | no |
| <a name="input_external_dns_chart_name"></a> [external\_dns\_chart\_name](#input\_external\_dns\_chart\_name) | The chart name to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_external_dns_chart_version"></a> [external\_dns\_chart\_version](#input\_external\_dns\_chart\_version) | The chart version to install external-dns | `string` | `"1.12.0"` | no |
| <a name="input_external_dns_domain_filter"></a> [external\_dns\_domain\_filter](#input\_external\_dns\_domain\_filter) | The domain filter to install external-dns | `string` | `"dev.assafushy.com"` | no |
| <a name="input_external_dns_enabled"></a> [external\_dns\_enabled](#input\_external\_dns\_enabled) | Whether to install external-dns | `bool` | `false` | no |
| <a name="input_external_dns_extra_values"></a> [external\_dns\_extra\_values](#input\_external\_dns\_extra\_values) | Extra values to pass to the chart | `map(string)` | `{}` | no |
| <a name="input_external_dns_namespace"></a> [external\_dns\_namespace](#input\_external\_dns\_namespace) | The namespace to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_external_dns_service_account_name"></a> [external\_dns\_service\_account\_name](#input\_external\_dns\_service\_account\_name) | The service account name to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_gke_count"></a> [gke\_count](#input\_gke\_count) | Set to 1 if we wish to enable GKE, 0 otherwise | `number` | `1` | no |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | The secondary ip range to use for pods | `string` | `"wf-dev-subnet-01-secondary-pods-01"` | no |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | The secondary ip range to use for services | `string` | `"wf-dev-subnet-01-secondary-services-02"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the VPC network to create | `string` | `"wf-dev"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | `"us-central1"` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether the cluster is regional | `bool` | `false` | no |
| <a name="input_remove_default_node_pool"></a> [remove\_default\_node\_pool](#input\_remove\_default\_node\_pool) | Whether the default node pool should be removed | `bool` | `true` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The name of the subnetwork to create | `string` | `"wf-dev-subnet-01"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in | `list(string)` | <pre>[<br>  "us-central1-a"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_certificate"></a> [ca\_certificate](#output\_ca\_certificate) | n/a |
| <a name="output_cluster_domain"></a> [cluster\_domain](#output\_cluster\_domain) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
