module "eks" {
  source                                 = "./cluster"
  cluster_name                           = var.cluster_name
  vpc_id                                 = var.vpc_id
  public_subnet_ids                      = var.public_subnet_ids
  private_subnet_ids                     = var.private_subnet_ids
  kubernets_version                      = var.kubernets_version
  security_alb_ingress_security_group_id = module.security_alb_ingress.security_group_id
  security_node_security_group_id        = module.security_node.security_group_id
}
