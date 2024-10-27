# keda_poc

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.70 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keda_irsa_role"></a> [keda\_irsa\_role](#module\_keda\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.34.0 |
| <a name="module_py-sqs-policy"></a> [py-sqs-policy](#module\_py-sqs-policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 2.12.2 |
| <a name="module_py_irsa_role"></a> [py\_irsa\_role](#module\_py\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.34.0 |
| <a name="module_sqs-policy"></a> [sqs-policy](#module\_sqs-policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 2.12.2 |

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.keda_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.py_sqs_access_policy_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.sqs_access_policy_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [kubectl_manifest.app](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.keda_scaledobject_sqs](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.py-keda-consumer](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.py-keda-producer](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.sa](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [aws_iam_policy_document.py-sqs-operator-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.py-sqs-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs-operator-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_deployment_name"></a> [app\_deployment\_name](#input\_app\_deployment\_name) | Name of app Deployment to be scaled | `string` | `"keda-app"` | no |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | tflint-ignore: terraform\_unused\_declarations | `string` | `"keda"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The Keda helm chart version | `string` | `"2.13"` | no |
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | The Cluster oidc provider | `string` | n/a | yes |
| <a name="input_consumer_deployment_name"></a> [consumer\_deployment\_name](#input\_consumer\_deployment\_name) | Name of keda consumer Deployment | `string` | `"keda-consumer"` | no |
| <a name="input_cooldown_period"></a> [cooldown\_period](#input\_cooldown\_period) | The time it takes to scale back down in seconds | `number` | `2` | no |
| <a name="input_enable_keda_poc"></a> [enable\_keda\_poc](#input\_enable\_keda\_poc) | To enable the keda poc or just install the keda operator | `bool` | `false` | no |
| <a name="input_keda_service_account_name"></a> [keda\_service\_account\_name](#input\_keda\_service\_account\_name) | The Service account that allows the keda operator perform operation in the EKS cluster | `string` | `"keda-operator"` | no |
| <a name="input_max_replica_count"></a> [max\_replica\_count](#input\_max\_replica\_count) | The maximum replica count | `number` | `10` | no |
| <a name="input_min_replica_count"></a> [min\_replica\_count](#input\_min\_replica\_count) | The minimum replica count | `number` | `0` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"keda"` | no |
| <a name="input_polling_interval"></a> [polling\_interval](#input\_polling\_interval) | The interval at which keda polls the target in seconds | `number` | `2` | no |
| <a name="input_producer_deployment_name"></a> [producer\_deployment\_name](#input\_producer\_deployment\_name) | Name of keda  producer Deployment | `string` | `"keda-producer"` | no |
| <a name="input_py_service_account_name"></a> [py\_service\_account\_name](#input\_py\_service\_account\_name) | n/a | `string` | `"sqs-test"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Keda Chart Repository | `string` | `"https://kedacore.github.io/charts"` | no |
| <a name="input_sqs_name"></a> [sqs\_name](#input\_sqs\_name) | n/a | `string` | `"keda-queue"` | no |
| <a name="input_sqs_policy_actions"></a> [sqs\_policy\_actions](#input\_sqs\_policy\_actions) | Permissions to attach to the SQS Policy | `list(string)` | <pre>[<br>  "sqs:SendMessage"<br>]</pre> | no |
| <a name="input_sqs_queue_length"></a> [sqs\_queue\_length](#input\_sqs\_queue\_length) | The queue length used to scaled the workloads | `string` | `"10"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keda_irsa_role_arn"></a> [keda\_irsa\_role\_arn](#output\_keda\_irsa\_role\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
