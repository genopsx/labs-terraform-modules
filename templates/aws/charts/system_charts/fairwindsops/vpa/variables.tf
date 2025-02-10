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
