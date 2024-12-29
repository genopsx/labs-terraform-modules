resource "helm_release" "yunikorn" {
  name             = var.yunikorn_release_name
  chart            = var.yunikorn_chart_name
  namespace        = "yunikorn"
  create_namespace = true
  repository       = "https://apache.github.io/yunikorn-release"
  version          = var.yunikorn_chart_version
}
