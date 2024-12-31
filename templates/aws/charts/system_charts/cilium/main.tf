# module "eks_cilium" {
#   source          = "git::https://github.com/tf-cilium/terraform-eks-cilium.git"
#   azs             = var.azs
#   cidr            = var.vpc_cidr_block
#   cilium          = var.cilium
#   cluster_name    = var.cluster_name
#   cluster_version = var.cluster_version
#   install_cilium  = var.install_cilium
#   service_cidr    = var.cluster_service_cidr
#   vpc_name        = var.vpc_name
# }

######################
resource "cilium" "this" {
  count = var.install_cilium ? 1 : 0
  set = [
    "cluster.name=${var.cluster_name}"
  ]
  version = var.cilium_version
}
