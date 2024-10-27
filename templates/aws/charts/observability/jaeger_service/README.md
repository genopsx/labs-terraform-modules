# jaeger_service

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.jaeger](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The acm certificate arn of the jaeger | `string` | n/a | yes |
| <a name="input_demo_app_enabled"></a> [demo\_app\_enabled](#input\_demo\_app\_enabled) | Deploy Jaeger demo application to test the service | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name of the jaeger | `string` | n/a | yes |
| <a name="input_jaeger_helm_chart_version"></a> [jaeger\_helm\_chart\_version](#input\_jaeger\_helm\_chart\_version) | The version of the jaeger helm chart | `string` | `"2.0.1"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the jaeger | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy the jaeger | `string` | `"jaeger"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the jaeger | `string` | n/a | yes |
| <a name="input_scheme"></a> [scheme](#input\_scheme) | The scheme of the jaeger | `string` | `"internet-facing"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jaeger_demo_url"></a> [jaeger\_demo\_url](#output\_jaeger\_demo\_url) | n/a |
| <a name="output_jaeger_url"></a> [jaeger\_url](#output\_jaeger\_url) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
