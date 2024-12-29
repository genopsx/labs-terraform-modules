resource "helm_release" "nvidia_device_plugin" {
  name             = var.nvdp_release_name
  chart            = var.nvdp_chart_name
  namespace        = "nvidia"
  create_namespace = true
  repository       = "https://nvidia.github.io/k8s-device-plugin"
  version          = var.nvdp_chart_version # e.g., "0.13.0"
}
