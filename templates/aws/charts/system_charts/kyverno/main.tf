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
