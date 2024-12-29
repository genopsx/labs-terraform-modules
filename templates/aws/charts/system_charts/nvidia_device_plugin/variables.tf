variable "nvdp_release_name" {
  type    = string
  default = "nvidia-device-plugin"
}

variable "nvdp_chart_name" {
  type    = string
  default = "k8s-device-plugin"
}

variable "nvdp_chart_version" {
  type    = string
  default = "0.13.0" # Replace with your desired version
}
