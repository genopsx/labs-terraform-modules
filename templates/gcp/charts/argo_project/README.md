# argo_project

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ./argocd | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_admin_team_name"></a> [argocd\_admin\_team\_name](#input\_argocd\_admin\_team\_name) | Name of admin team | `string` | `"argocd-admins"` | no |
| <a name="input_argocd_chart_name"></a> [argocd\_chart\_name](#input\_argocd\_chart\_name) | Name of the chart to install | `string` | `"argo-cd"` | no |
| <a name="input_argocd_chart_version"></a> [argocd\_chart\_version](#input\_argocd\_chart\_version) | Version of the chart to install | `string` | `"5.41.2"` | no |
| <a name="input_argocd_configure_initial_gitops_repo"></a> [argocd\_configure\_initial\_gitops\_repo](#input\_argocd\_configure\_initial\_gitops\_repo) | Configure initial gitops repo | `bool` | `false` | no |
| <a name="input_argocd_configure_sso"></a> [argocd\_configure\_sso](#input\_argocd\_configure\_sso) | Flag if needs to configure SSO | `bool` | `false` | no |
| <a name="input_argocd_create_root_app"></a> [argocd\_create\_root\_app](#input\_argocd\_create\_root\_app) | Flag if needs to create root application | `bool` | `false` | no |
| <a name="input_argocd_enabled"></a> [argocd\_enabled](#input\_argocd\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_argocd_extra_values"></a> [argocd\_extra\_values](#input\_argocd\_extra\_values) | Extra values in key value format | `map(any)` | `{}` | no |
| <a name="input_argocd_hostname"></a> [argocd\_hostname](#input\_argocd\_hostname) | Hostname of argocd | `string` | n/a | yes |
| <a name="input_argocd_initial_gitops_repo_password"></a> [argocd\_initial\_gitops\_repo\_password](#input\_argocd\_initial\_gitops\_repo\_password) | value of password for initial gitops repo | `string` | n/a | yes |
| <a name="input_argocd_initial_gitops_repo_url"></a> [argocd\_initial\_gitops\_repo\_url](#input\_argocd\_initial\_gitops\_repo\_url) | Initial gitops repo url | `string` | n/a | yes |
| <a name="input_argocd_initial_gitops_repo_username"></a> [argocd\_initial\_gitops\_repo\_username](#input\_argocd\_initial\_gitops\_repo\_username) | value of username for initial gitops repo | `string` | n/a | yes |
| <a name="input_argocd_main_project_name"></a> [argocd\_main\_project\_name](#input\_argocd\_main\_project\_name) | Name of main project | `string` | `"main"` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | Namespace to install the chart into | `string` | `"argocd"` | no |
| <a name="input_argocd_release_name"></a> [argocd\_release\_name](#input\_argocd\_release\_name) | Name of release | `string` | `"argocd"` | no |
| <a name="input_argocd_root_app_destination"></a> [argocd\_root\_app\_destination](#input\_argocd\_root\_app\_destination) | Destination of root application | `string` | `"in-cluster"` | no |
| <a name="input_argocd_root_app_dir_recurse"></a> [argocd\_root\_app\_dir\_recurse](#input\_argocd\_root\_app\_dir\_recurse) | Flag if root application directory needs to be recursed | `bool` | `false` | no |
| <a name="input_argocd_root_app_exclude"></a> [argocd\_root\_app\_exclude](#input\_argocd\_root\_app\_exclude) | List of root application directories to be excluded | `string` | `""` | no |
| <a name="input_argocd_root_app_name"></a> [argocd\_root\_app\_name](#input\_argocd\_root\_app\_name) | Name of root application | `string` | `"root_app"` | no |
| <a name="input_argocd_root_app_path"></a> [argocd\_root\_app\_path](#input\_argocd\_root\_app\_path) | Path of root application | `string` | `"apps"` | no |
| <a name="input_argocd_root_app_target_revision"></a> [argocd\_root\_app\_target\_revision](#input\_argocd\_root\_app\_target\_revision) | Target revision of root application | `string` | `"HEAD"` | no |
| <a name="input_argocd_serviceaccount"></a> [argocd\_serviceaccount](#input\_argocd\_serviceaccount) | Serviceaccount name to install the chart into | `string` | `"argocd"` | no |
| <a name="input_argocd_sso_client_id"></a> [argocd\_sso\_client\_id](#input\_argocd\_sso\_client\_id) | SSO client id | `string` | n/a | yes |
| <a name="input_argocd_sso_org"></a> [argocd\_sso\_org](#input\_argocd\_sso\_org) | SSO organization | `string` | n/a | yes |
| <a name="input_argocd_sso_provider"></a> [argocd\_sso\_provider](#input\_argocd\_sso\_provider) | SSO provider. Possible values: google, github, gitlab, dex | `string` | n/a | yes |
| <a name="input_certificate_issuer_name"></a> [certificate\_issuer\_name](#input\_certificate\_issuer\_name) | Name of cert-manager certificate issuer | `string` | `"letsencrypt-prod"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of K8S cluster | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not exist | `bool` | `true` | no |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | Recreate pods in the deployment if necessary | `bool` | `true` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | All Argo project Repository to install the chart from | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout for the helm release | `number` | `1200` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
