variable "cluster_version" {
  type        = string
  description = "Version of the cluster"
}
# Kyverno
variable "kyverno_chart_name" {
  type        = string
  description = "Name of chart"
}

variable "kyverno_chart_version" {
  type        = string
  description = "Version of kyverno chart"
}

variable "kyverno_namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

variable "kyverno_release_name" {
  type        = string
  description = "Name of release for kyverno"
}

# Kyverno policies
variable "kyverno_policies_release_name" {
  type        = string
  description = "Name of release for policy"
}

variable "kyverno_policies_chart_name" {
  type        = string
  description = "Name of chart for policy"
}

variable "kyverno_policies_chart_version" {
  type        = string
  description = "Version of the chart for policy"
}
