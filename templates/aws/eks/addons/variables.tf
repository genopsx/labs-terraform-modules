variable "tags" {
  description = "Tags to be attached to resources"
  type        = map(string)
}

variable "cluster_name" {
  type        = string
  description = "The name of the eks cluster"
}

variable "cluster_certificate_authority_data" {
  type        = string
  description = "The base64 encoded certificate data required to communicate with your cluster"
}
variable "cluster_endpoint" {
  type        = string
  description = "The endpoint for your eks kubernetes api server"
}

variable "cluster_version" {
  type        = string
  description = "The kubernetes server version for the eks cluster"
}

variable "oidc_provider_arn" {
  type        = string
  description = "The arn of the oidc identity provider"
}

# tflint-ignore: terraform_unused_declarations
variable "aws_region" {
  type        = string
  description = "Aws region"
}

variable "eks_addons" {
  type = map(object({
    most_recent              = bool
    resolve_conflicts        = string
    service_account_role_arn = optional(string)
  }))
  description = "The eks addons to be installed"
}
