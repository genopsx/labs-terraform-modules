module "eks_blueprints_addons" {
  source            = "./addons"
  cluster_name      = module.cluster.cluster_name
  cluster_version   = module.cluster.cluster_version
  oidc_provider_arn = module.cluster.oidc_provider_arn
  cluster_endpoint  = module.cluster.cluster_endpoint

  eks_addons = {
    amazon-cloudwatch-observability = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
  }
  tags = var.tags
  # depends_on = [module.nodes]
}
