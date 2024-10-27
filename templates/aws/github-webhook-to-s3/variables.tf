variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
  default     = "image-factory"
}

variable "source_code_bucket_arn" {
  type        = string
  description = "The ARN of bucket that hosts the source code (created externally)"
}

variable "source_code_bucket_kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key to decrypt the bucket that hosts the source code (created externally)"
  default     = ""
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

variable "build_image" {
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
  description = "Image to use for the CodeBuild resource"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "deployment_branches" {
  description = "List of branches that should be deployed"
  type        = list(string)
  default     = ["main"]
}

variable "deployment_file_name" {
  description = "The file name of the archive created out of the branches that will be deployed. Please note that the '.zip' extension will be added"
  type        = string
  default     = "deployment"
}

variable "merge_requests_file_name" {
  description = "The file name of the archive created out of the branches that will be only tested (run up to the plan phase). Please note that the '.zip' extension will be added"
  type        = string
  default     = "planonly"
}

variable "git_repo" {
  description = "The GitHub repo, usually in the form <organisation>/<repo name>"
  type        = string
}

variable "codebuild_cloudwatch_group_name" {
  type        = string
  description = "The group name to identify CloudBuild's CloudWatch logs"
  default     = null
}

variable "use_as_pipeline_trigger" {
  type        = bool
  description = "Whether to copy the repo content to a location that triggers a pipeline or store it using the tag (branch) name."
  default     = false
}

variable "include_git_metadata" {
  type        = bool
  description = "Include the .git folder in the archive"
  default     = false
}
