# variable "azs" {
#   type    = list(string)
#   default = []
# }

# variable "vpc_cidr_block" {
#   type    = string
#   default = ""
# }

# variable "cluster_name" {
#   type    = string
#   default = ""
# }

# variable "cluster_version" {
#   type    = string
#   default = ""
# }

# variable "cluster_service_cidr" {
#   type    = string
#   default = ""
# }

# variable "vpc_name" {
#   type    = string
#   default = ""
# }


# variable "cilium" {
#   description = "Feature of cilium"
#   type = object({
#     version                = optional(string, "1.14.3")
#     kube-proxy-replacement = optional(bool, false)
#     ebpf-hostrouting       = optional(bool, false)
#     hubble                 = optional(bool, false)
#     hubble-ui              = optional(bool, false)
#     gateway-api            = optional(bool, false)
#     preflight-version      = optional(string, null)
#     upgrade-compatibility  = optional(string, null)
#   })
#   default = {
#     version                = "1.15.4"
#     kube-proxy-replacement = false
#     ebpf-hostrouting       = false
#     hubble                 = false
#     hubble-ui              = false
#     gateway-api            = false
#   }
# }


variable "cilium_version" {
  description = "Cilium version"
  type        = string
  default     = "1.15.4"
}

variable "install_cilium" {
  type    = bool
  default = false
}

variable "cluster_name" {
  type    = string
  default = ""
}
