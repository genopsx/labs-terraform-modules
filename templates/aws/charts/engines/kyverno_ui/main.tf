resource "helm_release" "kyverno_ui" {
  count            = var.ui_enabled ? 1 : 0
  name             = var.policy_reporter_helm_chart_name
  chart            = var.policy_reporter_release_name
  repository       = "https://kyverno.github.io/policy-reporter"
  version          = var.policy_reporter_helm_chart_version
  create_namespace = true
  namespace        = var.policy_reporter_namespace

  # set {
  #   name  = "ui.enabled"
  #   value = true
  # }

  # set {
  #   name  = "ui.plugins.kyverno"
  #   value = true
  # }

  # set {
  #   name  = "kyvernoPlugin.enabled"
  #   value = true
  # }
  values = [local.base_values]
  # values = [
  #   yamlencode(var.policy_reporter_settings)
  # ]
}
