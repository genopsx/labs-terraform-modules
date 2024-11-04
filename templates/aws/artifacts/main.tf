module "source_code" {
  source          = "./source_code_bucket"
  resource_prefix = var.resource_prefix
}
