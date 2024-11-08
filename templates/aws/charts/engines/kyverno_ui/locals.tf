locals {
  # Kyverno UI 
  base_values = templatefile("${path.module}/policy_reporter/values.yaml", {
    cert_arn                     = var.certificate_arn
    domain                       = var.domain_name
    policy_reporter_release_name = var.policy_reporter_release_name
  })
}
