# source-code-bucket

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.70 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_source_code_bucket"></a> [source\_code\_bucket](#module\_source\_code\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.15.1 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.source_code_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.source_code_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.source_code_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_s3_bucket_notification.source_code_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.source_code_bucket_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.source_code_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | The canned ACL profile | `string` | `"private"` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Enable object versioning | `bool` | `true` | no |
| <a name="input_external_full_access_objects_arns"></a> [external\_full\_access\_objects\_arns](#input\_external\_full\_access\_objects\_arns) | List of ARNs that have full access to the bucekt's objects | `list(string)` | `[]` | no |
| <a name="input_force_destroy_buckets"></a> [force\_destroy\_buckets](#input\_force\_destroy\_buckets) | Test mode: force destroy buckets | `bool` | `false` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | The onwnership policy of the object created in the bucket | `string` | `"ObjectWriter"` | no |
| <a name="input_qualify_bucket_name"></a> [qualify\_bucket\_name](#input\_qualify\_bucket\_name) | Append the region and the account id | `bool` | `true` | no |
| <a name="input_resource_base_name"></a> [resource\_base\_name](#input\_resource\_base\_name) | The name that appears after the suffix | `string` | `"source-code"` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to use to name resources | `string` | `"image-factory"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_custom_kms_key"></a> [use\_custom\_kms\_key](#input\_use\_custom\_kms\_key) | Create a KMS key for the bucket's object(s) encryption | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_code_store_bucket_arn"></a> [code\_store\_bucket\_arn](#output\_code\_store\_bucket\_arn) | n/a |
| <a name="output_code_store_bucket_id"></a> [code\_store\_bucket\_id](#output\_code\_store\_bucket\_id) | n/a |
| <a name="output_code_store_bucket_kms_key_arn"></a> [code\_store\_bucket\_kms\_key\_arn](#output\_code\_store\_bucket\_kms\_key\_arn) | n/a |
<!-- END_TF_DOCS -->
