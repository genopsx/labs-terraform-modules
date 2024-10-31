# Required to get token for authorization on EKS
# data "aws_eks_cluster_auth" "eks" {
#   name = var.cluster_name
# }

data "aws_region" "current" {}
