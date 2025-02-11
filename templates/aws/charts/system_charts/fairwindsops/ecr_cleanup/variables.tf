variable "namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

variable "chart_version" {
  type        = string
  description = "Version of the chart"
}

variable "release_name" {
  type        = string
  description = "Name of the helm release"
}

variable "ecr-cleanup-repos" {
  description = "comma-separated list of repository names to watch."
  type        = string
}

variable "ecr-cleanup-region" {
  description = "region to use when talking to AWS. (default \"us-east-1\")"
  type        = string
}

variable "ecr-cleanup-namespaces" {
  description = "do not remove images used by pods in this comma-separated list of namespaces. (default \"default\")"
  type        = string
}

variable "cluster_oidc_provider_arn" {
  type        = string
  description = "The ARN of the OIDC provider for the EKS cluster"
}
