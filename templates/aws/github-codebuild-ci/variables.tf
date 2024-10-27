variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
  default     = "image-factory"
}

variable "codebuild_cache_bucket_id" {
  type        = string
  description = "The bucket used for CodeBuild's cache (created externally)"
}

variable "codebuild_role_name" {
  type        = string
  description = "The name of the CodeBuild role"
}

variable "create_github_webhook" {
  type        = bool
  description = "Whether to create the GitHub webhook or not"
  default     = true
}

variable "codebuild_vpc_id" {
  type        = string
  description = "The VPC used for the CodeBuild projects"
}

variable "build_compute_type" {
  default     = "BUILD_GENERAL1_SMALL"
  description = "Compute type to use for the CodeBuild resource."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "git_repo" {
  description = "The GitHub repo, usually in the form <organisation>/<repo name>"
  type        = string
}

variable "deployment_branches" {
  description = "The branches that are going to be deployed, i.e., those excluded from the CI"
  type        = list(string)
  default     = ["main"]
}

variable "build_projects" {
  type        = list(string)
  description = "The build projects, i.e., the script(s) with the test(s) to run against each environment"
  default     = ["ci"]
}

variable "buildspecs_definitions" {
  description = "A hash containig the buildspecs to be used for the CodeBuild projects. The keys are the build projects"
  type        = map(string)
  default     = {}
}

variable "build_environment_variables" {
  description = "Additional environment variable(s) for the build(s)"
  type        = map(string)
  default     = {}
}

variable "terragrunt_version" {
  type        = string
  description = "The Terragrunt version (as Docker image tag)"
  default     = "aws-tf-1.5.5-tg-0.50.4"
}

variable "terragrunt_parallelism" {
  type        = number
  description = "The number of modules that Terragrunt runs in parallel when executing an '-all' command"
  default     = 25
}

variable "terragrunt_environments" {
  description = "The Terragrunt environments, from the 'git_repo' root"
  type = map(object(
    {
      workload_role_arn = string
      apply_changes     = string
      base_folder       = string
    }
    )
  )
}

variable "skip_ci" {
  description = "The environments that should not be tested"
  type        = list(string)
  default     = []
}
