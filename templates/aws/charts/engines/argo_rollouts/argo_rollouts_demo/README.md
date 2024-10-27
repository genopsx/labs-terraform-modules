# argo_rollouts_demo

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 2.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.analysis_template_fail](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.analysis_template_success](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_rollouts_demo_green](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_rollouts_demo_red](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.argo_rollouts_demo_yellow](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.canary_service](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.ingress](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.root_service](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.stable_service](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [time_sleep.wait_120_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_60_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_selector_label"></a> [app\_selector\_label](#input\_app\_selector\_label) | n/a | `string` | `"rollouts-demo"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not exist | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Roure53 hosted zone name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name to deploy helm release | `string` | n/a | yes |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Name of release | `string` | n/a | yes |
| <a name="input_traffic_light_demo_enabled"></a> [traffic\_light\_demo\_enabled](#input\_traffic\_light\_demo\_enabled) | Create traffic\_light rollout demo | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
