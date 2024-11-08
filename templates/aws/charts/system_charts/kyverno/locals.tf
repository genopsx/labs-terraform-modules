locals {
  # Kyverno Cluster Policy
  kyverno_cluster_policy_yaml_path = "${path.module}/cluster_wide_psa/kyverno_cluster_wide_psa.yaml"
  kyverno_cluster_policy_yaml = templatefile(local.kyverno_cluster_policy_yaml_path, {
    cluster_version = var.cluster_version
  })

  # Kyverno UI 
  kyverno_ui_yaml_path = "${path.module}/policy_reporter/values.yaml"
  kyverno_ui_yaml = templatefile(local.kyverno_ui_yaml_path, {
    cert_arn                     = var.certificate_arn
    domain                       = var.domain_name
    policy_reporter_release_name = var.policy_reporter_release_name
  })
}
