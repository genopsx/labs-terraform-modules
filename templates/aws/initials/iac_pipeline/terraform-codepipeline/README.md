# terraform-codepipeline

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_artefacts_store"></a> [artefacts\_store](#module\_artefacts\_store) | terraform-aws-modules/s3-bucket/aws | 3.15.1 |
| <a name="module_codebuild_cache"></a> [codebuild\_cache](#module\_codebuild\_cache) | terraform-aws-modules/s3-bucket/aws | 3.15.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.codepipeline_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.codepipeline_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_codebuild_project.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarconnections_connection.codestar_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |
| [aws_iam_policy.codebuild_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_dynamodb_table_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_sts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_terraform_state_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_vpc_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codepipeline_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codepipeline_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codepipeline_codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eventbridge_codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eventbridge_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_codebuild_svc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_dynamodb_table_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_sts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_terraform_state_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild_vpc_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codepipeline_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codepipeline_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codepipeline_codepipeline_svc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codepipeline_codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eventbridge_codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.codepipeline_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.codepipeline_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.codepipeline_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_event_bus.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_event_bus) | data source |
| [aws_iam_policy.codebuilddevaccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.codepipelinefullaccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.artefacts_store_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_dynamodb_table_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_sts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_terraform_state_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_vpc_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eventbridge_codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eventbridge_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.source_code_bucket_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_bucket.code_store](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_security_group.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_environment_variables"></a> [build\_environment\_variables](#input\_build\_environment\_variables) | Additional environment variable(s) for the build(s) | `map(string)` | `{}` | no |
| <a name="input_build_projects"></a> [build\_projects](#input\_build\_projects) | The build projects, one for each Terragrunt job | `list(string)` | <pre>[<br>  "validate",<br>  "plan",<br>  "apply"<br>]</pre> | no |
| <a name="input_buildspecs_definitions"></a> [buildspecs\_definitions](#input\_buildspecs\_definitions) | A hash containig the buildspecs to be used for the CodePipeline's actions (CodeBuild based). The keys are the build projects | `map(string)` | `{}` | no |
| <a name="input_codebuild_vpc_id"></a> [codebuild\_vpc\_id](#input\_codebuild\_vpc\_id) | The VPC used for the CodeBuild projects | `string` | n/a | yes |
| <a name="input_compute_type"></a> [compute\_type](#input\_compute\_type) | Compute resources | `string` | `"BUILD_GENERAL1_MEDIUM"` | no |
| <a name="input_expiration_days_artefacts"></a> [expiration\_days\_artefacts](#input\_expiration\_days\_artefacts) | Number of days after which the artefacts should be deleted. | `number` | `30` | no |
| <a name="input_expiration_days_codebuild_cache"></a> [expiration\_days\_codebuild\_cache](#input\_expiration\_days\_codebuild\_cache) | Number of days after which the codebuild cache should be deleted. | `number` | `7` | no |
| <a name="input_force_destroy_buckets"></a> [force\_destroy\_buckets](#input\_force\_destroy\_buckets) | Test mode: force destroy buckets | `bool` | `false` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to use to name resources | `string` | `""` | no |
| <a name="input_source_code_base_path"></a> [source\_code\_base\_path](#input\_source\_code\_base\_path) | The path in the source code bucket where the Terragrunt file are located (usually the name of the Git repo) | `string` | `""` | no |
| <a name="input_source_code_bucket_id"></a> [source\_code\_bucket\_id](#input\_source\_code\_bucket\_id) | The bucket that hosts the source code (created externally) | `string` | n/a | yes |
| <a name="input_source_code_bucket_kms_key_arn"></a> [source\_code\_bucket\_kms\_key\_arn](#input\_source\_code\_bucket\_kms\_key\_arn) | The ARN of the KMS key to decrypt the bucket that hosts the source code (created externally) | `string` | `""` | no |
| <a name="input_source_code_deployment_file_name"></a> [source\_code\_deployment\_file\_name](#input\_source\_code\_deployment\_file\_name) | The file, inside the source\_code\_base\_path, which contains the Terragrunt code to be deployed | `string` | `"deployment.zip"` | no |
| <a name="input_source_code_github_branch"></a> [source\_code\_github\_branch](#input\_source\_code\_github\_branch) | The branch of the GitHub repo hosting the Terragrunt code for Image Factory | `string` | `"main"` | no |
| <a name="input_source_code_github_repo"></a> [source\_code\_github\_repo](#input\_source\_code\_github\_repo) | The GitHub repo hosting the Terragrunt code for Image Factory | `string` | `""` | no |
| <a name="input_source_code_origin"></a> [source\_code\_origin](#input\_source\_code\_origin) | Where to fetch the source code from: S3 or GitHub | `string` | `"GitHub"` | no |
| <a name="input_state_resource_prefix"></a> [state\_resource\_prefix](#input\_state\_resource\_prefix) | Prefix used in the name of the Terraform state related resources | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_terraform_state_buckets_arns"></a> [terraform\_state\_buckets\_arns](#input\_terraform\_state\_buckets\_arns) | The list of the S3 buckets' ARNs that contain the Terraform states | `list(string)` | `[]` | no |
| <a name="input_terraform_state_buckets_kms_keys_arns"></a> [terraform\_state\_buckets\_kms\_keys\_arns](#input\_terraform\_state\_buckets\_kms\_keys\_arns) | The list of the S3 buckets' KMS key ARNs that encrypt the Terraform buckets state | `list(string)` | `[]` | no |
| <a name="input_terraform_state_dynamodb_arns"></a> [terraform\_state\_dynamodb\_arns](#input\_terraform\_state\_dynamodb\_arns) | The list of the DynamoDB tables' ARNs that lock the Terraform states | `list(string)` | `[]` | no |
| <a name="input_terragrunt_environments"></a> [terragrunt\_environments](#input\_terragrunt\_environments) | The Terragrunt environments, from the 'git\_repo' root | <pre>map(object(<br>    {<br>      workload_role_arn = string<br>      apply_changes     = string<br>      base_folder       = string<br>    }<br>    )<br>  )</pre> | n/a | yes |
| <a name="input_terragrunt_parallelism"></a> [terragrunt\_parallelism](#input\_terragrunt\_parallelism) | The number of modules that Terragrunt runs in parallel when executing an '-all' command | `number` | `25` | no |
| <a name="input_terragrunt_version"></a> [terragrunt\_version](#input\_terragrunt\_version) | The Terragrunt version (as Docker image tag) | `string` | `"aws-tf-1.5.5-tg-0.50.4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artefacts_bucket_id"></a> [artefacts\_bucket\_id](#output\_artefacts\_bucket\_id) | The ID of the CodeBuild artefacts bucket |
| <a name="output_buckets_kms_key_id"></a> [buckets\_kms\_key\_id](#output\_buckets\_kms\_key\_id) | The if of the KMS key that encrypts the cache and artefacts buckets |
| <a name="output_codebuild_cache_bucket_id"></a> [codebuild\_cache\_bucket\_id](#output\_codebuild\_cache\_bucket\_id) | The ID of the CodeBuild cache bucket |
| <a name="output_codebuild_role_name"></a> [codebuild\_role\_name](#output\_codebuild\_role\_name) | The name of the CodeBuild role |
| <a name="output_codepipeline_name"></a> [codepipeline\_name](#output\_codepipeline\_name) | The name of the deployment CodePipeline |
<!-- END_TF_DOCS -->
