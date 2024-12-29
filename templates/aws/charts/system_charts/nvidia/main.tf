resource "helm_release" "nvidia_device_plugin" {
  name             = var.nvdp_release_name
  chart            = var.nvdp_chart_name
  namespace        = "nvidia"
  create_namespace = true
  repository       = "https://nvidia.github.io/k8s-device-plugin"
  version          = var.nvdp_chart_version # e.g., "0.13.0"
}

resource "helm_release" "gpu_operator" {
  name             = "gpu-operator"
  chart            = "gpu-operator"
  namespace        = "nvidia"
  create_namespace = true
  repository       = "https://nvidia.github.io/gpu-operator"
  version          = "v24.9.1"
}

resource "helm_release" "network_operator" {
  name             = "network-operator"
  chart            = "network-operator"
  namespace        = "nvidia"
  create_namespace = true
  repository       = "https://helm.ngc.nvidia.com/nvidia"
  version          = "24.10.0"
}


resource "helm_release" "nim_operator" {
  name             = "nim-operator"
  chart            = "k8s-nim-operator"
  namespace        = "nvidia"
  create_namespace = true
  repository       = "https://helm.ngc.nvidia.com/nvidia"
  version          = "1.0.0"
}
