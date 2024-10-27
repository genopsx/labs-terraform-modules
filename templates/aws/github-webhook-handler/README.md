# github-webhook-handler

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_handler"></a> [handler](#module\_handler) | terraform-aws-modules/lambda/aws | 5.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_bus.image_factory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus) | resource |
| [aws_cloudwatch_metric_alarm.github_webhook_handler_invocations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_kms_alias.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_secretsmanager_secret.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.github_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.github_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_event_bus.image_factory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_event_bus) | data source |
| [aws_iam_policy_document.github_webhook_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_eventbridge_bus"></a> [custom\_eventbridge\_bus](#input\_custom\_eventbridge\_bus) | Whether to create a custom EventBridge bus or use the default one | `bool` | `true` | no |
| <a name="input_lambda_invocation_threshold"></a> [lambda\_invocation\_threshold](#input\_lambda\_invocation\_threshold) | The number of calls to the GitHub Webhook Lambda function in a 5 minutes interval that triggers an alarm | `number` | `50` | no |
| <a name="input_lambda_source_bucket_prefix"></a> [lambda\_source\_bucket\_prefix](#input\_lambda\_source\_bucket\_prefix) | The basename of the bucket which hosts the Lambda function's code | `string` | `"eventbridge-inbound-webhook-templates-prod"` | no |
| <a name="input_lambda_source_file_path"></a> [lambda\_source\_file\_path](#input\_lambda\_source\_file\_path) | The path (relative to an AWS bucket) with the Lambda function's code | `string` | `"lambda-templates/github-lambdasrc.zip"` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to use to name resources | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_custom_kms_key_for_token"></a> [use\_custom\_kms\_key\_for\_token](#input\_use\_custom\_kms\_key\_for\_token) | Create a custom KMS key to store the token in the SecretManager | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventbridge_bus_name"></a> [eventbridge\_bus\_name](#output\_eventbridge\_bus\_name) | The name of the EventBridge bus where the webhook handler sends the notifications |
| <a name="output_github_secret_token"></a> [github\_secret\_token](#output\_github\_secret\_token) | The secret token to be passed to GitHub's webhook |
| <a name="output_github_webhook_handler_url"></a> [github\_webhook\_handler\_url](#output\_github\_webhook\_handler\_url) | The URL to pass to GitHub |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
