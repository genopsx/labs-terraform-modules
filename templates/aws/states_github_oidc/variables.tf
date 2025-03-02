variable "account_name" {
  type        = string
  description = "The name of the account"
  default     = "genopsx"
}

variable "resource_prefix" {
  type        = string
  description = "The string to prepend to each resource's name"
}

variable "iac" {
  type        = string
  description = "Name of the IaC"
}

variable "terraform_trusted_arns" {
  type        = list(string)
  description = "The ARNs for Terraform's role trusted policy"
}

variable "github_org" {
  type        = string
  description = "Name of GitHub organization/user (case sensitive)"
}

variable "repository_1" {
  type        = string
  description = "Name of GitHub repository (case sensitive)"
}

variable "repository_2" {
  type        = string
  description = "Name of GitHub repository (case sensitive)"
}

variable "oidc_provider_arn" {
  type        = string
  description = "Arn for the GitHub OIDC Provider"
}

variable "oidc_provider_thumbprint_list" {
  type        = list(string)
  description = "The list of the OIDC provider's certificate thumbprint(s)"
}

variable "oidc_audience" {
  type        = string
  description = "Audience supplied to configure-aws-credentials."
}
