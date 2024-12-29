# kong_ingress_controller

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
| [helm_release.kong](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_values"></a> [extra\_values](#input\_extra\_values) | Extra values to pass to the chart | `map(string)` | `{}` | no |
| <a name="input_kong_chart_version"></a> [kong\_chart\_version](#input\_kong\_chart\_version) | The version of the chart | `string` | `"2.42.0"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the chart | `string` | `"kong"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the chart | `string` | `"kong"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
