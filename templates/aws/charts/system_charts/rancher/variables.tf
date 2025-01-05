variable "rancher_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "rancher"
}

variable "rancher_chart_name" {
  type        = string
  description = "Helm chart to release"
  default     = "rancher"
}


variable "rancher_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "cattle-system"
}

variable "rancher_chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "1.15.0"
}

variable "domain_name" {
  type        = string
  description = "Roure53 hosted zone name"
  default     = ""
}

variable "certificate_arn" {
  type        = string
  description = "ACM Certificate ARN"
  default     = ""
}
