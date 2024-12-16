# https://github.com/kyverno/kyverno
resource "helm_release" "kyverno" {
  name             = var.kyverno_release_name
  repository       = "https://kyverno.github.io/kyverno/"
  chart            = var.kyverno_chart_name
  version          = var.kyverno_chart_version
  create_namespace = true
  namespace        = var.kyverno_namespace

  # High Availability (https://kyverno.io/docs/installation/methods/)
  set {
    name  = "admissionController.replicas"
    value = "3"
  }

  set {
    name  = "backgroundController.replicas"
    value = "2"
  }

  set {
    name  = "cleanupController.replicas"
    value = "2"
  }

  set {
    name  = "reportsController.replicas"
    value = "2"
  }
  // Omitting namespace to install Kyverno cluster-wide
  // namespace = "kyverno"
}


resource "helm_release" "kyverno_policies" {
  depends_on = [helm_release.kyverno]
  name       = var.kyverno_policies_release_name
  repository = "https://kyverno.github.io/kyverno/"
  chart      = var.kyverno_policies_chart_name
  version    = var.kyverno_policies_chart_version
  namespace  = var.kyverno_namespace # Make sure to deploy in the same namespace as Kyverno
  # Add any additional attributes or values here if needed
}

resource "kubectl_manifest" "kyverno_cluster_policy" {
  depends_on = [helm_release.kyverno_policies]
  yaml_body  = local.kyverno_cluster_policy_yaml

  lifecycle {
    precondition {
      condition     = fileexists(local.kyverno_cluster_policy_yaml_path)
      error_message = " --> Error: Failed to find '${local.kyverno_cluster_policy_yaml_path}'. Exit terraform process."
    }
  }
}

# By default, Kyverno is configured with minimal permissions and does not have access to security sensitive resources like Secrets. 
# You can provide additional permissions using cluster role aggregation. 
# The following role permits the Kyverno background-controller to create (clone) secrets.
# https://kyverno.io/docs/introduction/quick-start/
resource "kubectl_manifest" "secrets_clone_config" {
  depends_on = [helm_release.kyverno_policies]
  for_each   = { for file in local.kyverno_secret_clone_config_yamls_path : file => file }
  yaml_body  = templatefile("${path.module}/additional_configs/secrets_clone/${each.key}", local.vars)
}

# Next, create the following Kyverno policy. 
# The sync-secrets policy will match on any newly-created Namespace 
# and will clone the Secret we just created earlier into that new Namespace.
resource "kubectl_manifest" "secrets_clone_policy" {
  depends_on = [kubectl_manifest.secrets_clone_config]
  yaml_body  = local.kyverno_secret_clone_policy_yaml

  lifecycle {
    precondition {
      condition     = fileexists(local.kyverno_secret_clone_policy_yaml_path)
      error_message = " --> Error: Failed to find '${local.kyverno_secret_clone_policy_yaml_path}'. Exit terraform process."
    }
  }
}
