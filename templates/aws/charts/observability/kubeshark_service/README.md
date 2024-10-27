# kubeshark_service

<!-- BEGIN_TF_DOCS -->
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
| [helm_release.kubeshark](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The acm certificate arn of the kubeshark | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name of the kubeshark | `string` | n/a | yes |
| <a name="input_kubeshark_helm_chart_version"></a> [kubeshark\_helm\_chart\_version](#input\_kubeshark\_helm\_chart\_version) | The version of the kubeshark helm chart | `string` | `"52.1.77"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the kubeshark | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy the kubeshark | `string` | `"kubeshark"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the kubeshark | `string` | n/a | yes |
| <a name="input_scheme"></a> [scheme](#input\_scheme) | The scheme of the kubeshark | `string` | `"internet-facing"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeshark_url"></a> [kubeshark\_url](#output\_kubeshark\_url) | n/a |
<!-- END_TF_DOCS -->
