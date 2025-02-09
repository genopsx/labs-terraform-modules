locals {
  base_values = templatefile("${path.module}/values.yaml", {

    prometheus_sub_release_name   = var.prometheus_sub_release_name
    grafana_sub_release_name      = var.grafana_sub_release_name
    alertmanager_sub_release_name = var.alertmanager_sub_release_name
    domain                        = var.domain_name
    cert_arn                      = var.certificate_arn

  })
}


