variable "policy_reporter_settings" {
  type        = map(any)
  description = "Settings for policy reporter"
}

variable "policy_reporter_namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

variable "policy_reporter_helm_chart_name" {
  type        = string
  description = "Name of the chart to install"
}

variable "policy_reporter_helm_chart_version" {
  type        = string
  description = "Version of the chart to install"
}

variable "ui_enabled" {
  type        = bool
  description = "Enable the UI"
  default     = false
}

# variable "domain_name" {
#   type        = string
#   description = "Roure53 hosted zone name"
# }
# variable "certificate_arn" {
#   type        = string
#   description = "ACM certificate ARN"
# }

variable "policy_reporter_release_name" {
  type        = string
  description = "Name of the release"
}
