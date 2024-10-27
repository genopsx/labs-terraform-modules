# acm_r53

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.70 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_certificate"></a> [certificate](#module\_certificate) | terraform-aws-modules/acm/aws | 4.3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.cluster_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.parent_hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | `""` | no |
| <a name="input_r53_hosted_zone_name"></a> [r53\_hosted\_zone\_name](#input\_r53\_hosted\_zone\_name) | The hosted zone name | `string` | `""` | no |
| <a name="input_r53_subzone_name"></a> [r53\_subzone\_name](#input\_r53\_subzone\_name) | The subzone name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to the resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
