locals {
  kyverno_cluster_policy_yaml_path = "${path.module}/cluster_wide_psa/kyverno_cluster_wide_psa.yaml"
  kyverno_cluster_policy_yaml = templatefile(local.kyverno_cluster_policy_yaml_path, {
    cluster_version = var.cluster_version
  })
}
