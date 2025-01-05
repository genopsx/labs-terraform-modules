resource "helm_release" "rancher" {
  name             = var.rancher_release_name
  chart            = var.rancher_chart_name
  namespace        = var.rancher_namespace
  create_namespace = true
  repository       = "https://releases.rancher.com/server-charts/latest"
  version          = var.rancher_chart_version
  values           = [local.base_values]
}

