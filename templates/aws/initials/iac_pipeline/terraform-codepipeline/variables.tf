variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
  default     = ""
}

variable "state_resource_prefix" {
  type        = string
  description = "Prefix used in the name of the Terraform state related resources"
  default     = ""
}

variable "terraform_state_buckets_arns" {
  type        = list(string)
  description = "The list of the S3 buckets' ARNs that contain the Terraform states"
  default     = []
}

variable "terraform_state_buckets_kms_keys_arns" {
  type        = list(string)
  description = "The list of the S3 buckets' KMS key ARNs that encrypt the Terraform buckets state"
  default     = []
}

variable "terraform_state_dynamodb_arns" {
  type        = list(string)
  description = "The list of the DynamoDB tables' ARNs that lock the Terraform states"
  default     = []
}

variable "source_code_origin" {
  type        = string
  description = "Where to fetch the source code from: S3 or GitHub"
  default     = "GitHub"
  validation {
    condition     = can(regex("^(S3|GitHub)$", var.source_code_origin))
    error_message = "The allowed values are S3 or GitHub"
  }
}

### Source code bucket: it should be needed, Terragrunt gets the modules from there

variable "source_code_bucket_id" {
  type        = string
  description = "The bucket that hosts the source code (created externally)"
}

variable "source_code_bucket_kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key to decrypt the bucket that hosts the source code (created externally)"
  default     = ""
}

variable "source_code_base_path" {
  type        = string
  description = "The path in the source code bucket where the Terragrunt file are located (usually the name of the Git repo)"
  default     = ""
}

### Variables related to the GitHub CodeStar connection

variable "source_code_github_repo" {
  type        = string
  description = "The GitHub repo hosting the Terragrunt code for Image Factory"
  default     = ""
}

variable "source_code_github_branch" {
  type        = string
  description = "The branch of the GitHub repo hosting the Terragrunt code for Image Factory"
  default     = "main"
}

### Variables related to the S3 source code bucket, when used as CodePipeline start trigger

variable "source_code_deployment_file_name" {
  type        = string
  description = "The file, inside the source_code_base_path, which contains the Terragrunt code to be deployed"
  default     = "deployment.zip"
}

###

variable "expiration_days_artefacts" {
  description = "Number of days after which the artefacts should be deleted."
  type        = number
  default     = 30
}

variable "expiration_days_codebuild_cache" {
  description = "Number of days after which the codebuild cache should be deleted."
  type        = number
  default     = 7
}

variable "build_environment_variables" {
  description = "Additional environment variable(s) for the build(s)"
  type        = map(string)
  default     = {}
}

variable "build_projects" {
  type        = list(string)
  description = "The build projects, one for each Terragrunt job"
  default     = ["validate", "plan", "apply"]
}

variable "buildspecs_definitions" {
  description = "A hash containig the buildspecs to be used for the CodePipeline's actions (CodeBuild based). The keys are the build projects"
  type        = map(string)
  default     = {}
}

variable "codebuild_vpc_id" {
  type        = string
  description = "The VPC used for the CodeBuild projects"
}

variable "compute_type" {
  type        = string
  description = "Compute resources"
  default     = "BUILD_GENERAL1_MEDIUM"
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

variable "force_destroy_buckets" {
  type        = bool
  description = "Test mode: force destroy buckets"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
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
