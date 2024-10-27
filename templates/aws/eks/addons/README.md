# eks_addons

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.70 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | aws-ia/eks-blueprints-addons/aws | ~> 1.0 |
| <a name="module_velero_backup_s3_bucket"></a> [velero\_backup\_s3\_bucket](#module\_velero\_backup\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | The endpoint of the eks cluster | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the eks cluster | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The kubernetes server version for the eks cluster | `string` | n/a | yes |
| <a name="input_eks_addons"></a> [eks\_addons](#input\_eks\_addons) | The eks addons to be installed | <pre>map(object({<br>    most_recent              = bool<br>    resolve_conflicts        = string<br>    service_account_role_arn = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The arn of the oidc identity provider | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be attached to resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Selected AWS Account ID |
| <a name="output_region"></a> [region](#output\_region) | Details about selected AWS region |
<!-- END_TF_DOCS -->
