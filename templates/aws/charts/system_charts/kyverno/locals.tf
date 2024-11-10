locals {
  # Kyverno Cluster Policy
  kyverno_cluster_policy_yaml_path = "${path.module}/policies/kyverno_cluster_wide_psa.yaml"
  kyverno_cluster_policy_yaml = templatefile(local.kyverno_cluster_policy_yaml_path, {
    cluster_version = var.cluster_version
  })

  # Kyverno Secret Clone Policy
  kyverno_secret_clone_policy_yaml_path = "${path.module}/policies/sync-secrets.yaml"
  kyverno_secret_clone_policy_yaml      = templatefile(local.kyverno_secret_clone_policy_yaml_path, {})

  # Kyverno Additional Configurations
  kyverno_secret_clone_config_yamls_path = fileset("${path.module}/additional_configs/secret_clone", "*.yaml")
  vars                                   = {}

  # Kyverno More policyies (to be deployed by argocd)

}
