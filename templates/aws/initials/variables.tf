variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
}

variable "provider_role_arn" {
  type        = string
  description = "The role to assume when running Terragrunt"
  default     = ""
}

variable "terragrunt_environments_file_name" {
  description = "The YAML file containing the Terragrunt environments, as expected by the 'terraform-codepipeline' module"
  type        = string
  default     = "terragrunt_environments.yml"
}