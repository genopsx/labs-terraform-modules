resource "helm_release" "gemini" {
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version
  name             = var.release_name
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "gemini"
  wait             = true # Wait for the deployment to be ready before marking the resource as complete
}



