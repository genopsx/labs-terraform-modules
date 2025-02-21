# CLUSTER AUTO-SCALERS
module "cluster_autoscaler" {
  count                     = var.cluster_autoscaler_enabled && !var.karpenter_enabled ? 1 : 0
  source                    = "./cluster_autoscaler"
  enabled                   = var.cluster_autoscaler_enabled
  namespace                 = var.cluster_autoscaler_namespace
  region                    = var.region
  cluster_name              = var.cluster_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
}

# KARPENTER
module "karpenter" {
  count                     = var.karpenter_enabled && !var.cluster_autoscaler_enabled ? 1 : 0
  source                    = "./karpenter"
  namespace                 = var.karpenter_namespace
  cluster_name              = var.cluster_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  region                    = var.region
  cluster_endpoint          = var.cluster_endpoint
}

# module "kyvernos" {
#   count                 = var.kyverno_enabled ? 1 : 0
#   source                = "./kyverno"
#   depends_on            = [module.karpenter]
#   cluster_version       = var.cluster_version
#   kyverno_chart_name    = var.kyverno_chart_name
#   kyverno_chart_version = var.kyverno_chart_version
#   kyverno_namespace     = var.kyverno_namespace
#   kyverno_release_name  = var.kyverno_release_name

#   # Kyverno Policies
#   kyverno_policies_release_name  = var.kyverno_policies_release_name
#   kyverno_policies_chart_name    = var.kyverno_policies_chart_name
#   kyverno_policies_chart_version = var.kyverno_policies_chart_version
# }


# YUNIKORN
# module "yunikorn" {
#   count                  = var.yunikorn_enabled ? 1 : 0
#   source                 = "./yunikorn"
#   yunikorn_release_name  = var.yunikorn_release_name
#   yunikorn_chart_name    = var.yunikorn_chart_name
#   yunikorn_chart_version = var.yunikorn_chart_version
# }

# NVIDIA
module "nvidia" {
  count              = var.nvidia_enabled ? 1 : 0
  source             = "./nvidia"
  nvdp_release_name  = var.nvdp_release_name
  nvdp_chart_name    = var.nvdp_chart_name
  nvdp_chart_version = var.nvdp_chart_version
}

# INGRESS CONTROLLERS
module "alb_controller" {
  count                     = var.alb_controller_enabled && !var.kong_enabled ? 1 : 0
  source                    = "./alb_controller"
  namespace                 = var.alb_controller_namespace
  create_role_enabled       = true
  region                    = var.region
  cluster_name              = var.cluster_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  vpc_id                    = var.vpc_id
}

# KONG
module "kong" {
  count     = var.kong_enabled && !var.alb_controller_enabled ? 1 : 0
  source    = "./kong_ingress_controller"
  namespace = var.kong_namespace
}
# IF Both alb_controller_enabled and kong_enabled are set to true, none will be created
# Because of the logical conditions
# count     = var.kong_enabled && !var.alb_controller_enabled ? 1 : 0
# count                     = var.alb_controller_enabled && !var.kong_enabled ? 1 : 0
# Meaning Only one of them can be enabled at a time or isolte condition as follows:


# module "kong" {
#   count = var.kong_enabled ? 1 : 0
#   ...
# }

# CUSTOM HELM ADDONS
module "eks_blueprints_addons" {
  source                    = "./custom_helm_addons"
  cluster_name              = var.cluster_name
  cluster_version           = var.cluster_version
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  cluster_endpoint          = var.cluster_endpoint
  enabled_custom_helm       = var.enabled_custom_helm
  tags                      = var.tags
}

# NODE TERMINATION HANDLER
module "aws_node_termination_handler" {
  count        = var.aws_node_termination_handler_enabled ? 1 : 0
  source       = "./aws_node_termination_handler"
  namespace    = var.aws_node_termination_handler_namespace
  cluster_name = var.cluster_name
}

module "metrics_server" {
  count        = var.metrics_server_enabled ? 1 : 0
  source       = "./metrics_server"
  namespace    = var.metrics_server_namespace
  cluster_name = var.cluster_name
}

# EBS CSI DRIVER
module "ebs_csi_driver" {
  count                     = var.ebs_csi_enabled ? 1 : 0
  source                    = "./ebs_csi"
  namespace                 = var.ebs_csi_driver_namespace
  region                    = var.region
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
}


# EXTERNAL DNS
module "eks_external_dns" {
  count                     = var.eks_external_dns_enabled ? 1 : 0
  source                    = "./eks_external_dns"
  cluster_name              = var.cluster_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  domain_name               = var.domain_name
  region                    = var.region
  namespace                 = var.external_dns_namespace
  create_role_enabled       = true
}

# CERTIFICATE MANAGER
module "cert_manager" {
  count        = var.cert_manager_enabled ? 1 : 0
  source       = "./certificate_manager"
  cluster_name = var.cluster_name
  namespace    = var.cert_manager_namespace
}

# SECRETS MANAGER
module "external_secrets" {
  count                     = var.external_secrets_enabled ? 1 : 0
  source                    = "./external_secrets"
  region                    = var.region
  namespace                 = var.external_secrets_namespace
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  secrets_regex             = var.external_secrets_regex
}

# PODS AUTO-SCALERS
module "keda" {
  count                     = var.keda_enabled ? 1 : 0
  source                    = "./keda_operator"
  namespace                 = var.keda_namespace
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  keda_poc_enabled          = var.keda_poc_enabled
  region                    = var.region
}

# RANCHER
module "rancher" {
  count                 = var.rancher_enabled ? 1 : 0
  source                = "./rancher"
  domain_name           = var.domain_name
  certificate_arn       = var.acm_certificate_arn
  rancher_release_name  = var.rancher_release_name
  rancher_chart_name    = var.rancher_chart_name
  rancher_namespace     = var.rancher_namespace
  rancher_chart_version = var.rancher_chart_version
}

# VPA (Vertical Pod Autoscaler)
module "vpa" {
  count         = var.vpa_enabled ? 1 : 0
  source        = "./fairwindsops/vpa"
  release_name  = var.vpa_release_name
  chart_version = var.vpa_chart_version
  namespace     = var.vpa_namespace
}

# GOLDILOCKS
module "goldilocks" {
  count           = var.goldilocks_enabled ? 1 : 0
  source          = "./fairwindsops/goldilocks"
  release_name    = var.goldilocks_release_name
  chart_version   = var.goldilocks_chart_version
  namespace       = var.goldilocks_namespace
  domain_name     = var.domain_name
  certificate_arn = var.acm_certificate_arn
  depends_on      = [module.vpa]
}

# POLARIS (The Cert Manager is a dependency for Polaris)
module "polaris" {
  count           = var.polaris_enabled ? 1 : 0
  source          = "./fairwindsops/polaris"
  release_name    = var.polaris_release_name
  chart_version   = var.polaris_chart_version
  namespace       = var.polaris_namespace
  domain_name     = var.domain_name
  certificate_arn = var.acm_certificate_arn
  depends_on      = [module.vpa, module.cert_manager]
}

# GEMINI
module "gemini" {
  count         = var.gemini_enabled ? 1 : 0
  source        = "./fairwindsops/gemini"
  release_name  = var.gemini_release_name
  chart_version = var.gemini_chart_version
  namespace     = var.gemini_namespace
  depends_on    = [module.vpa]
}

# HELM RELEASE PRUNER
module "helm_release_pruner" {
  count         = var.helm_release_pruner_enabled ? 1 : 0
  source        = "./fairwindsops/helm_release_pruner"
  namespace     = var.helm_release_pruner_namespace
  release_name  = var.helm_release_pruner_release_name
  chart_version = var.helm_release_pruner_chart_version
  depends_on    = [module.vpa]
}

# RBAC MANAGER
module "rbac_manager" {
  count         = var.rbac_manager_enabled ? 1 : 0
  source        = "./fairwindsops/rbac_manager"
  namespace     = var.rbac_manager_namespace
  release_name  = var.rbac_manager_release_name
  chart_version = var.rbac_manager_chart_version
  depends_on    = [module.vpa]
}

# INSIGHTS ADMISION
module "insights_admission" {
  count         = var.insights_admission_enabled ? 1 : 0
  source        = "./fairwindsops/insights_admission"
  namespace     = var.insights_admission_namespace
  release_name  = var.insights_admission_release_name
  chart_version = var.insights_admission_chart_version
  depends_on    = [module.vpa]
}

# ECR CLEANUP
module "ecr_cleanup" {
  count                     = var.ecr_cleanup_enabled ? 1 : 0
  source                    = "./fairwindsops/ecr_cleanup"
  namespace                 = var.ecr_cleanup_namespace
  release_name              = var.ecr_cleanup_release_name
  chart_version             = var.ecr_cleanup_chart_version
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  ecr-cleanup-repos         = var.ecr-cleanup-repos
  ecr-cleanup-region        = var.ecr-cleanup-region
  ecr-cleanup-namespaces    = var.ecr-cleanup-namespaces
  depends_on                = [module.vpa]
}

# AWS IAM AUTHENTICATOR
module "aws_iam_authenticator" {
  count         = var.aws_iam_authenticator_enabled ? 1 : 0
  source        = "./fairwindsops/aws_iam_authenticator"
  namespace     = var.aws_iam_authenticator_namespace
  release_name  = var.aws_iam_authenticator_release_name
  chart_version = var.aws_iam_authenticator_chart_version
  depends_on    = [module.vpa]
}
