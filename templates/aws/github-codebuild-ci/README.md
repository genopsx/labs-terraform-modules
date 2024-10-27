# github-codebuild-ci

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.github_codebuild_ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_webhook.github_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |
| [aws_iam_role.github_codebuild_ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_s3_bucket.codebuild_cache_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_security_group.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_compute_type"></a> [build\_compute\_type](#input\_build\_compute\_type) | Compute type to use for the CodeBuild resource. | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_build_environment_variables"></a> [build\_environment\_variables](#input\_build\_environment\_variables) | Additional environment variable(s) for the build(s) | `map(string)` | `{}` | no |
| <a name="input_build_projects"></a> [build\_projects](#input\_build\_projects) | The build projects, i.e., the script(s) with the test(s) to run against each environment | `list(string)` | <pre>[<br>  "ci"<br>]</pre> | no |
| <a name="input_buildspecs_definitions"></a> [buildspecs\_definitions](#input\_buildspecs\_definitions) | A hash containig the buildspecs to be used for the CodeBuild projects. The keys are the build projects | `map(string)` | `{}` | no |
| <a name="input_codebuild_cache_bucket_id"></a> [codebuild\_cache\_bucket\_id](#input\_codebuild\_cache\_bucket\_id) | The bucket used for CodeBuild's cache (created externally) | `string` | n/a | yes |
| <a name="input_codebuild_role_name"></a> [codebuild\_role\_name](#input\_codebuild\_role\_name) | The name of the CodeBuild role | `string` | n/a | yes |
| <a name="input_codebuild_vpc_id"></a> [codebuild\_vpc\_id](#input\_codebuild\_vpc\_id) | The VPC used for the CodeBuild projects | `string` | n/a | yes |
| <a name="input_create_github_webhook"></a> [create\_github\_webhook](#input\_create\_github\_webhook) | Whether to create the GitHub webhook or not | `bool` | `true` | no |
| <a name="input_deployment_branches"></a> [deployment\_branches](#input\_deployment\_branches) | The branches that are going to be deployed, i.e., those excluded from the CI | `list(string)` | <pre>[<br>  "main"<br>]</pre> | no |
| <a name="input_git_repo"></a> [git\_repo](#input\_git\_repo) | The GitHub repo, usually in the form <organisation>/<repo name> | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | Prefix to use to name resources | `string` | `"image-factory"` | no |
| <a name="input_skip_ci"></a> [skip\_ci](#input\_skip\_ci) | The environments that should not be tested | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_terragrunt_environments"></a> [terragrunt\_environments](#input\_terragrunt\_environments) | The Terragrunt environments, from the 'git\_repo' root | <pre>map(object(<br>    {<br>      workload_role_arn = string<br>      apply_changes     = string<br>      base_folder       = string<br>    }<br>    )<br>  )</pre> | n/a | yes |
| <a name="input_terragrunt_parallelism"></a> [terragrunt\_parallelism](#input\_terragrunt\_parallelism) | The number of modules that Terragrunt runs in parallel when executing an '-all' command | `number` | `25` | no |
| <a name="input_terragrunt_version"></a> [terragrunt\_version](#input\_terragrunt\_version) | The Terragrunt version (as Docker image tag) | `string` | `"aws-tf-1.5.5-tg-0.50.4"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
