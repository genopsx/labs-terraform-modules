variable "cluster_name" {
  type        = string
  description = "The name of the eks cluster"
}
variable "cluster_version" {
  type        = string
  description = "The kubernetes server version for the eks cluster"
}

variable "cluster_oidc_provider_arn" {
  type        = string
  description = "The arn of the oidc identity provider"
}

variable "cluster_endpoint" {
  type        = string
  description = "The endpoint of the eks cluster"
}

variable "enabled_custom_helm" {
  description = "Flag to enable or disable the creation of custom Helm addons and associated resources"
  type        = bool
  default     = false # Set to true to create the resources
}

variable "tags" {
  type        = map(string)
  description = "Tags to be attached to resources"
}
