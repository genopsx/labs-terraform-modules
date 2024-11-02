# github_runners

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_actions_runner_controller"></a> [actions\_runner\_controller](#module\_actions\_runner\_controller) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.github-runner-helm-deploy-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_ssm_parameter.github_webhook_secret_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.runnerRegistrationToken](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [helm_release.actions-runner-controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.github-runner-helm-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.WebhookServer_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.runnerRegistrationToken](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_helm_chart_version"></a> [cert\_manager\_helm\_chart\_version](#input\_cert\_manager\_helm\_chart\_version) | Cert Manager Helm chart version. | `string` | `"1.11.0"` | no |
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | EKS cluster OIDC provider ARN | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Variable indicating whether Cert Manager deployment is enabled. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"dev"` | no |
| <a name="input_github_helm_charts_s3_bucket"></a> [github\_helm\_charts\_s3\_bucket](#input\_github\_helm\_charts\_s3\_bucket) | S3 bucket name to keep Helm charts | `string` | `""` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub PAT token | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"actions-runner-system"` | no |
| <a name="input_runnerGithubURL"></a> [runnerGithubURL](#input\_runnerGithubURL) | n/a | `string` | `""` | no |
| <a name="input_runners_deploy_list"></a> [runners\_deploy\_list](#input\_runners\_deploy\_list) | tflint-ignore: terraform\_unused\_declarations | <pre>list(object({<br>    name          = optional(string)<br>    repository    = optional(string)<br>    limits_cpu    = optional(string)<br>    limits_memory = optional(string)<br>    replicas_min  = optional(number)<br>    replicas_max  = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_serviceaccount"></a> [serviceaccount](#input\_serviceaccount) | Serviceaccount for Github runners | `string` | `"actions-runner-system"` | no |
| <a name="input_ssm_prefix"></a> [ssm\_prefix](#input\_ssm\_prefix) | SSM Path to Github tokens | `string` | `"/github"` | no |
| <a name="input_token_ssm_parameter"></a> [token\_ssm\_parameter](#input\_token\_ssm\_parameter) | tflint-ignore: terraform\_unused\_declarations | `string` | `""` | no |
| <a name="input_webhook_server_enabled"></a> [webhook\_server\_enabled](#input\_webhook\_server\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_webhook_server_host"></a> [webhook\_server\_host](#input\_webhook\_server\_host) | n/a | `string` | `""` | no |
| <a name="input_webhook_server_path"></a> [webhook\_server\_path](#input\_webhook\_server\_path) | n/a | `string` | `"/"` | no |
| <a name="input_webhook_server_secret_enabled"></a> [webhook\_server\_secret\_enabled](#input\_webhook\_server\_secret\_enabled) | n/a | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
