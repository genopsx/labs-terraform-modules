module "states_github_oidc" {
  source                        = "./pipeline_bootstrap"
  account_name                  = var.account_name
  resource_prefix               = var.resource_prefix
  iac                           = var.iac
  terraform_trusted_arns        = var.terraform_trusted_arns
  github_org                    = var.github_org
  repository_1                  = var.repository_1
  repository_2                  = var.repository_2
  oidc_provider_arn             = var.oidc_provider_arn
  oidc_provider_thumbprint_list = var.oidc_provider_thumbprint_list
  oidc_audience                 = var.oidc_audience
}
