variable "codebuild_project_name" {
  type        = string
  description = "The name of the CodeBuild project"
}

variable "codebuild_build_timeout" {
  type        = number
  default     = 45
  description = "Default value for CodeBuild build timeout in minutes"
}

variable "codebuild_secrets_manager_access" {
  type = list(object({
    name          = string
    alias         = string
    key           = optional(string)
    version_stage = optional(string)
    version_id    = optional(string)
  }))
  default     = []
  description = "The list of secrets that will be used by CodeBuild"
}

variable "build_ecr_repository_kms_arn" {
  type        = string
  description = "The ARN of the KMS key used by the build ECR repository"
}

variable "build_ecr_repository_name" {
  type        = string
  description = "The name of the ECR repository to fetch the image from"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "log_group" {
  type        = string
  description = "The name of the CloudWatch log group"
}

variable "vpc_private_subnet_ids" {
  type        = list(string)
  description = "The private subnet IDs"
}

variable "vpc_private_subnet_arns" {
  type        = list(string)
  description = "The private subnet ARNs"
}

variable "vpc_default_security_group_id" {
  type        = string
  description = "The default security group ID"
}
