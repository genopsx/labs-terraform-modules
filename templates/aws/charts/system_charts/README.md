# system_charts

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.4.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_controller"></a> [alb\_controller](#module\_alb\_controller) | ./alb_controller | n/a |
| <a name="module_aws_iam_authenticator"></a> [aws\_iam\_authenticator](#module\_aws\_iam\_authenticator) | ./fairwindsops/aws_iam_authenticator | n/a |
| <a name="module_aws_node_termination_handler"></a> [aws\_node\_termination\_handler](#module\_aws\_node\_termination\_handler) | ./aws_node_termination_handler | n/a |
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./certificate_manager | n/a |
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | ./cluster_autoscaler | n/a |
| <a name="module_ebs_csi_driver"></a> [ebs\_csi\_driver](#module\_ebs\_csi\_driver) | ./ebs_csi | n/a |
| <a name="module_ecr_cleanup"></a> [ecr\_cleanup](#module\_ecr\_cleanup) | ./fairwindsops/ecr_cleanup | n/a |
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | ./custom_helm_addons | n/a |
| <a name="module_eks_external_dns"></a> [eks\_external\_dns](#module\_eks\_external\_dns) | ./eks_external_dns | n/a |
| <a name="module_external_secrets"></a> [external\_secrets](#module\_external\_secrets) | ./external_secrets | n/a |
| <a name="module_gemini"></a> [gemini](#module\_gemini) | ./fairwindsops/gemini | n/a |
| <a name="module_goldilocks"></a> [goldilocks](#module\_goldilocks) | ./fairwindsops/goldilocks | n/a |
| <a name="module_helm_release_pruner"></a> [helm\_release\_pruner](#module\_helm\_release\_pruner) | ./fairwindsops/helm_release_pruner | n/a |
| <a name="module_insights_admission"></a> [insights\_admission](#module\_insights\_admission) | ./fairwindsops/insights_admission | n/a |
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | ./karpenter | n/a |
| <a name="module_keda"></a> [keda](#module\_keda) | ./keda_operator | n/a |
| <a name="module_kong"></a> [kong](#module\_kong) | ./kong_ingress_controller | n/a |
| <a name="module_metrics_server"></a> [metrics\_server](#module\_metrics\_server) | ./metrics_server | n/a |
| <a name="module_nvidia"></a> [nvidia](#module\_nvidia) | ./nvidia | n/a |
| <a name="module_polaris"></a> [polaris](#module\_polaris) | ./fairwindsops/polaris | n/a |
| <a name="module_rancher"></a> [rancher](#module\_rancher) | ./rancher | n/a |
| <a name="module_rbac_manager"></a> [rbac\_manager](#module\_rbac\_manager) | ./fairwindsops/rbac_manager | n/a |
| <a name="module_vpa"></a> [vpa](#module\_vpa) | ./fairwindsops/vpa | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | tflint-ignore: terraform\_unused\_declarations | `string` | n/a | yes |
| <a name="input_alb_controller_enabled"></a> [alb\_controller\_enabled](#input\_alb\_controller\_enabled) | AWS LB Controller | `bool` | `false` | no |
| <a name="input_alb_controller_namespace"></a> [alb\_controller\_namespace](#input\_alb\_controller\_namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_aws_iam_authenticator_chart_version"></a> [aws\_iam\_authenticator\_chart\_version](#input\_aws\_iam\_authenticator\_chart\_version) | Version of the chart | `string` | `"0.1.0"` | no |
| <a name="input_aws_iam_authenticator_enabled"></a> [aws\_iam\_authenticator\_enabled](#input\_aws\_iam\_authenticator\_enabled) | AWS Iam Authenticator | `bool` | `false` | no |
| <a name="input_aws_iam_authenticator_namespace"></a> [aws\_iam\_authenticator\_namespace](#input\_aws\_iam\_authenticator\_namespace) | Namespace to install the chart into | `string` | `"kube-system"` | no |
| <a name="input_aws_iam_authenticator_release_name"></a> [aws\_iam\_authenticator\_release\_name](#input\_aws\_iam\_authenticator\_release\_name) | Name of the helm release | `string` | `"aws-iam-authenticator"` | no |
| <a name="input_aws_node_termination_handler_enabled"></a> [aws\_node\_termination\_handler\_enabled](#input\_aws\_node\_termination\_handler\_enabled) | AWS node termination handler | `bool` | `false` | no |
| <a name="input_aws_node_termination_handler_namespace"></a> [aws\_node\_termination\_handler\_namespace](#input\_aws\_node\_termination\_handler\_namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Whether to install cert-manager | `bool` | `false` | no |
| <a name="input_cert_manager_namespace"></a> [cert\_manager\_namespace](#input\_cert\_manager\_namespace) | The namespace to install cert-manager | `string` | `"cert-manager"` | no |
| <a name="input_cluster_autoscaler_enabled"></a> [cluster\_autoscaler\_enabled](#input\_cluster\_autoscaler\_enabled) | Cluster autoscaler | `bool` | `false` | no |
| <a name="input_cluster_autoscaler_namespace"></a> [cluster\_autoscaler\_namespace](#input\_cluster\_autoscaler\_namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | EKS cluster endpoint | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | The OIDC provider ARN for the EKS cluster | `string` | `"arn:aws:iam::account-id:oidc-provider/oidc.eks.region.amazonaws.com/id"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The Kubernetes version to use for the EKS cluster | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain filter to install external-dns | `string` | n/a | yes |
| <a name="input_ebs_csi_driver_namespace"></a> [ebs\_csi\_driver\_namespace](#input\_ebs\_csi\_driver\_namespace) | Namespace name to deploy helm release | `string` | `"kube-system"` | no |
| <a name="input_ebs_csi_enabled"></a> [ebs\_csi\_enabled](#input\_ebs\_csi\_enabled) | EBS CSI Driver | `bool` | `false` | no |
| <a name="input_ecr-cleanup-namespaces"></a> [ecr-cleanup-namespaces](#input\_ecr-cleanup-namespaces) | do not remove images used by pods in this comma-separated list of namespaces. (default "default") | `string` | n/a | yes |
| <a name="input_ecr-cleanup-region"></a> [ecr-cleanup-region](#input\_ecr-cleanup-region) | region to use when talking to AWS. (default "us-east-1") | `string` | n/a | yes |
| <a name="input_ecr-cleanup-repos"></a> [ecr-cleanup-repos](#input\_ecr-cleanup-repos) | comma-separated list of repository names to watch. | `string` | n/a | yes |
| <a name="input_ecr_cleanup_chart_version"></a> [ecr\_cleanup\_chart\_version](#input\_ecr\_cleanup\_chart\_version) | Version of the chart | `string` | `"0.1.0"` | no |
| <a name="input_ecr_cleanup_enabled"></a> [ecr\_cleanup\_enabled](#input\_ecr\_cleanup\_enabled) | Ecr Cleanup | `bool` | `false` | no |
| <a name="input_ecr_cleanup_namespace"></a> [ecr\_cleanup\_namespace](#input\_ecr\_cleanup\_namespace) | Namespace to install the chart into | `string` | `"kube-system"` | no |
| <a name="input_ecr_cleanup_release_name"></a> [ecr\_cleanup\_release\_name](#input\_ecr\_cleanup\_release\_name) | Name of the helm release | `string` | `"ecr-cleanup"` | no |
| <a name="input_eks_external_dns_enabled"></a> [eks\_external\_dns\_enabled](#input\_eks\_external\_dns\_enabled) | Whether to install external-dns for eks | `bool` | `false` | no |
| <a name="input_enabled_custom_helm"></a> [enabled\_custom\_helm](#input\_enabled\_custom\_helm) | Flag to enable or disable the creation of custom Helm addons and associated resources | `bool` | `false` | no |
| <a name="input_external_dns_namespace"></a> [external\_dns\_namespace](#input\_external\_dns\_namespace) | The namespace to install external-dns | `string` | `"external-dns"` | no |
| <a name="input_external_secrets_enabled"></a> [external\_secrets\_enabled](#input\_external\_secrets\_enabled) | External Secrets | `bool` | `false` | no |
| <a name="input_external_secrets_namespace"></a> [external\_secrets\_namespace](#input\_external\_secrets\_namespace) | Namespace name to deploy helm release | `string` | `"kube-system"` | no |
| <a name="input_external_secrets_regex"></a> [external\_secrets\_regex](#input\_external\_secrets\_regex) | AWS SM Secrets regex for ARN | `string` | `"*"` | no |
| <a name="input_gemini_chart_version"></a> [gemini\_chart\_version](#input\_gemini\_chart\_version) | Version of the chart | `string` | n/a | yes |
| <a name="input_gemini_enabled"></a> [gemini\_enabled](#input\_gemini\_enabled) | Gemini | `bool` | `false` | no |
| <a name="input_gemini_namespace"></a> [gemini\_namespace](#input\_gemini\_namespace) | Namespace to install the chart into | `string` | n/a | yes |
| <a name="input_gemini_release_name"></a> [gemini\_release\_name](#input\_gemini\_release\_name) | Name of the helm release | `string` | n/a | yes |
| <a name="input_goldilocks_chart_version"></a> [goldilocks\_chart\_version](#input\_goldilocks\_chart\_version) | Version of the chart | `string` | n/a | yes |
| <a name="input_goldilocks_enabled"></a> [goldilocks\_enabled](#input\_goldilocks\_enabled) | Goldilocks | `bool` | `false` | no |
| <a name="input_goldilocks_namespace"></a> [goldilocks\_namespace](#input\_goldilocks\_namespace) | Namespace to install the chart into | `string` | n/a | yes |
| <a name="input_goldilocks_release_name"></a> [goldilocks\_release\_name](#input\_goldilocks\_release\_name) | Name of the helm release | `string` | n/a | yes |
| <a name="input_helm_release_pruner_chart_version"></a> [helm\_release\_pruner\_chart\_version](#input\_helm\_release\_pruner\_chart\_version) | Version of the chart | `string` | `"0.1.0"` | no |
| <a name="input_helm_release_pruner_enabled"></a> [helm\_release\_pruner\_enabled](#input\_helm\_release\_pruner\_enabled) | Helm Release Pruner | `bool` | `false` | no |
| <a name="input_helm_release_pruner_namespace"></a> [helm\_release\_pruner\_namespace](#input\_helm\_release\_pruner\_namespace) | Namespace to install the chart into | `string` | `"kube-system"` | no |
| <a name="input_helm_release_pruner_release_name"></a> [helm\_release\_pruner\_release\_name](#input\_helm\_release\_pruner\_release\_name) | Name of the helm release | `string` | `"helm-release-pruner"` | no |
| <a name="input_insights_admission_chart_version"></a> [insights\_admission\_chart\_version](#input\_insights\_admission\_chart\_version) | Version of the chart | `string` | `"0.1.0"` | no |
| <a name="input_insights_admission_enabled"></a> [insights\_admission\_enabled](#input\_insights\_admission\_enabled) | Insights Admission | `bool` | `false` | no |
| <a name="input_insights_admission_namespace"></a> [insights\_admission\_namespace](#input\_insights\_admission\_namespace) | Namespace to install the chart into | `string` | `"kube-system"` | no |
| <a name="input_insights_admission_release_name"></a> [insights\_admission\_release\_name](#input\_insights\_admission\_release\_name) | Name of the helm release | `string` | `"insights-admission"` | no |
| <a name="input_karpenter_enabled"></a> [karpenter\_enabled](#input\_karpenter\_enabled) | Whether to install karpenter | `bool` | `false` | no |
| <a name="input_karpenter_namespace"></a> [karpenter\_namespace](#input\_karpenter\_namespace) | n/a | `string` | `"kube-system"` | no |
| <a name="input_keda_enabled"></a> [keda\_enabled](#input\_keda\_enabled) | Keda | `bool` | `false` | no |
| <a name="input_keda_namespace"></a> [keda\_namespace](#input\_keda\_namespace) | Namespace name to deploy helm release | `string` | `"keda"` | no |
| <a name="input_keda_poc_enabled"></a> [keda\_poc\_enabled](#input\_keda\_poc\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_kong_enabled"></a> [kong\_enabled](#input\_kong\_enabled) | Whether to install kong | `bool` | `false` | no |
| <a name="input_kong_namespace"></a> [kong\_namespace](#input\_kong\_namespace) | The namespace to install kong | `string` | `"kong"` | no |
| <a name="input_metrics_server_enabled"></a> [metrics\_server\_enabled](#input\_metrics\_server\_enabled) | Metrics Server | `bool` | `false` | no |
| <a name="input_metrics_server_namespace"></a> [metrics\_server\_namespace](#input\_metrics\_server\_namespace) | Namespace name to deploy helm release | `string` | `"kube-system"` | no |
| <a name="input_nvdp_chart_name"></a> [nvdp\_chart\_name](#input\_nvdp\_chart\_name) | Name of chart for nvidia-device-plugin | `string` | n/a | yes |
| <a name="input_nvdp_chart_version"></a> [nvdp\_chart\_version](#input\_nvdp\_chart\_version) | Version of the chart for nvidia-device-plugin | `string` | n/a | yes |
| <a name="input_nvdp_release_name"></a> [nvdp\_release\_name](#input\_nvdp\_release\_name) | Name of release for nvidia-device-plugin | `string` | n/a | yes |
| <a name="input_nvidia_enabled"></a> [nvidia\_enabled](#input\_nvidia\_enabled) | NVIDIA | `bool` | `false` | no |
| <a name="input_polaris_chart_version"></a> [polaris\_chart\_version](#input\_polaris\_chart\_version) | Version of the chart | `string` | n/a | yes |
| <a name="input_polaris_enabled"></a> [polaris\_enabled](#input\_polaris\_enabled) | Polaris | `bool` | `false` | no |
| <a name="input_polaris_namespace"></a> [polaris\_namespace](#input\_polaris\_namespace) | Namespace to install the chart into | `string` | n/a | yes |
| <a name="input_polaris_release_name"></a> [polaris\_release\_name](#input\_polaris\_release\_name) | Name of the helm release | `string` | n/a | yes |
| <a name="input_rancher_chart_name"></a> [rancher\_chart\_name](#input\_rancher\_chart\_name) | Helm chart to release | `string` | `"rancher"` | no |
| <a name="input_rancher_chart_version"></a> [rancher\_chart\_version](#input\_rancher\_chart\_version) | Helm chart to release | `string` | `"1.15.0"` | no |
| <a name="input_rancher_enabled"></a> [rancher\_enabled](#input\_rancher\_enabled) | Rancher | `bool` | `false` | no |
| <a name="input_rancher_namespace"></a> [rancher\_namespace](#input\_rancher\_namespace) | Namespace name to deploy helm release | `string` | `"cattle-system"` | no |
| <a name="input_rancher_release_name"></a> [rancher\_release\_name](#input\_rancher\_release\_name) | Name of the helm release | `string` | `"rancher"` | no |
| <a name="input_rbac_manager_chart_version"></a> [rbac\_manager\_chart\_version](#input\_rbac\_manager\_chart\_version) | Version of the chart | `string` | `"0.1.0"` | no |
| <a name="input_rbac_manager_enabled"></a> [rbac\_manager\_enabled](#input\_rbac\_manager\_enabled) | RBAC Manager | `bool` | `false` | no |
| <a name="input_rbac_manager_namespace"></a> [rbac\_manager\_namespace](#input\_rbac\_manager\_namespace) | Namespace to install the chart into | `string` | `"kube-system"` | no |
| <a name="input_rbac_manager_release_name"></a> [rbac\_manager\_release\_name](#input\_rbac\_manager\_release\_name) | Name of the helm release | `string` | `"rbac-manager"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be attached to resources | `map(string)` | n/a | yes |
| <a name="input_vpa_chart_version"></a> [vpa\_chart\_version](#input\_vpa\_chart\_version) | Version of the chart | `string` | n/a | yes |
| <a name="input_vpa_enabled"></a> [vpa\_enabled](#input\_vpa\_enabled) | Fairwinds vpa (Vertical Pod Autoscaler) | `bool` | `false` | no |
| <a name="input_vpa_namespace"></a> [vpa\_namespace](#input\_vpa\_namespace) | Namespace to install the chart into | `string` | n/a | yes |
| <a name="input_vpa_release_name"></a> [vpa\_release\_name](#input\_vpa\_release\_name) | Name of the helm release | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to host the cluster in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_secret_store_ref_name"></a> [cluster\_secret\_store\_ref\_name](#output\_cluster\_secret\_store\_ref\_name) | n/a |
| <a name="output_goldilocks_url"></a> [goldilocks\_url](#output\_goldilocks\_url) | n/a |
| <a name="output_polaris_url"></a> [polaris\_url](#output\_polaris\_url) | n/a |
<!-- END_TF_DOCS -->
