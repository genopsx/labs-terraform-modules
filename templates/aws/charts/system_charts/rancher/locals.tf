locals {
  base_values = templatefile("${path.module}/values.yaml", {
    release_name = var.rancher_release_name
    domain       = var.domain_name
    cert_arn     = var.certificate_arn
  })
}
