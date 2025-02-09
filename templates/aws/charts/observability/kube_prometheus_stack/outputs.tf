output "grafana_url" {
  value = "https://${var.grafana_sub_release_name}.${var.domain_name}"
}

output "prometheus_url" {
  value = "https://${var.prometheus_sub_release_name}.${var.domain_name}"
}

output "alertmanager_url" {
  value = "https://${var.alertmanager_sub_release_name}.${var.domain_name}"
}
