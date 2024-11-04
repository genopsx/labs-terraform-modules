module "source_code" {
  source          = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//source-code-bucket"
  resource_prefix = var.resource_prefix
}
