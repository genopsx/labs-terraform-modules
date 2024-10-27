module "eks_blueprints_addons" {
  source                             = "./addons"
  aws_region                         = data.aws_region.current.name
  cluster_name                       = module.eks.cluster_name
  cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  cluster_endpoint                   = module.eks.cluster_endpoint
  cluster_version                    = module.eks.cluster_version
  oidc_provider_arn                  = module.eks.oidc_provider_arn

  eks_addons = {
    amazon-cloudwatch-observability = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
  }
  tags = var.tags
  # depends_on = [module.nodes]
}
