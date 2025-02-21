variable "kube_prometheus_stack_namespace" {
  type        = string
  description = "kube-prometheus-stack_namespace namespace name to deploy helm release"
  default     = "monitoring"
}
variable "kube_prometheus_stack_chart_version" {
  type        = string
  description = "Version of kube-prometheus-stack chart"
  default     = "68.3.0"
}

variable "extra_values" {
  type        = map(any)
  description = "Extra values in key value format"
  default     = {}
}


variable "domain_name" {
  type        = string
  description = "Roure53 hosted zone name"
}

variable "certificate_arn" {
  type        = string
  description = "ACM Certificate ARN"
}

variable "prometheus_sub_release_name" {
  type        = string
  description = "Prometheus sub release name"
  default     = "prometheus"
}

variable "grafana_sub_release_name" {
  type        = string
  description = "Grafana sub release name"
  default     = "grafana"
}

variable "alertmanager_sub_release_name" {
  type        = string
  description = "Alertmanager sub release name"
  default     = "alertmanager"
}

variable "grafana_auths_secret_mgr_arn" {
  type        = string
  description = "ARN of the secret with Grafana auths"
}
