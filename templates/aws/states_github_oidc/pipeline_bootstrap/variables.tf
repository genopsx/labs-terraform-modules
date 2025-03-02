variable "account_name" {
  type        = string
  description = "The name of the account"
  default     = "genopsx"
}

variable "resource_prefix" {
  type        = string
  description = "The string to prepend to each resource's name"
  default     = "deployment"
}

variable "iac" {
  type        = string
  description = "Name of the IaC"
  default     = "terragrunt"
}

variable "terraform_trusted_arns" {
  type        = list(string)
  description = "The ARNs for Terraform's role trusted policy"
  default = [
    "arn:aws:iam::955769636964:role/eks-admin-role"
  ]
}

variable "github_org" {
  type        = string
  description = "Name of GitHub organization/user (case sensitive)"
  default     = "genopsx"
}

variable "repository_1" {
  type        = string
  description = "Name of GitHub repository (case sensitive)"
  default     = "labs-terraform"
}

variable "repository_2" {
  type        = string
  description = "Name of GitHub repository (case sensitive)"
  default     = "labs-terraform-modules"
}

variable "oidc_provider_arn" {
  type        = string
  description = "Arn for the GitHub OIDC Provider"
  default     = "arn:aws:iam::955769636964:oidc-provider/token.actions.githubusercontent.com"
}

variable "oidc_provider_thumbprint_list" {
  type        = list(string)
  description = "The list of the OIDC provider's certificate thumbprint(s)"
  default     = ["ffffffffffffffffffffffffffffffffffffffff"]
}

variable "oidc_audience" {
  type        = string
  description = "Audience supplied to configure-aws-credentials."
  default     = "sts.amazonaws.com"
}
