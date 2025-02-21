resource "helm_release" "fairwinds_insights" {
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version
  name             = var.release_name
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "fairwinds-insights"
  values           = [local.base_values]
  wait             = true # Wait for the deployment to be ready before marking the resource as complete
}
