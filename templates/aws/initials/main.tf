locals {
  terragrunt_environments = yamldecode(file("${path.module}/${var.terragrunt_environments_file_name}"))
}

module "source_code" {
  source          = "./iac_pipeline/source-code-bucket"
  resource_prefix = var.resource_prefix
}

module "actions" {
  source = "./iac_pipeline/image-factory-buildspecs"
}

# module "network" {
#   source               = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//network"
#   resource_prefix      = var.resource_prefix
#   privatelink_services = ["s3", "dynamodb"]
# }

# # Create the state resources in eu-central-1 using the default AWS provider
# module "tf_state_eu_central_1" {
#   source          = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//terraform-state-resources"
#   resource_prefix = var.resource_prefix
# }

# # Create the state resources in us-east-1 using the dedicated regional provider
# module "tf_state_us_east_1" {
#   source          = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//terraform-state-resources"
#   resource_prefix = var.resource_prefix
#   providers = {
#     aws = aws.us-east-1
#   }
# }

module "terraform_codepipeline" {
  source                         = "./iac_pipeline/terraform-codepipeline"
  resource_prefix                = var.resource_prefix
  codebuild_vpc_id               = var.vpc_id
  source_code_github_repo        = "kwatatshey/labs-terraform-modules"
  source_code_bucket_id          = module.source_code.code_store_bucket_id
  source_code_bucket_kms_key_arn = module.source_code.code_store_bucket_kms_key_arn
  buildspecs_definitions         = module.actions.buildspecs
  terragrunt_environments        = local.terragrunt_environments
  terragrunt_parallelism         = 5
  build_environment_variables = {
    TF_RECREATE_MISSING_LAMBDA_PACKAGE = "true"
  }
  terraform_state_buckets_arns          = ["arn:aws:s3:::deployment-states-terragrunt-sbx-eu-west-1-955769636964"]
  terraform_state_buckets_kms_keys_arns = ["arn:aws:kms:eu-west-1:955769636964:key/53e2108b-0481-4fcb-8b7e-9f1ed1d25b8f"]
  terraform_state_dynamodb_arns         = ["deployment-locks-terragrunt-sbx-eu-west-1-955769636964"]
}

module "github_ci" {
  source                    = "./iac_pipeline/github-codebuild-ci"
  resource_prefix           = var.resource_prefix
  codebuild_vpc_id          = var.vpc_id
  codebuild_cache_bucket_id = module.terraform_codepipeline.codebuild_cache_bucket_id
  codebuild_role_name       = module.terraform_codepipeline.codebuild_role_name
  git_repo                  = "kwatatshey/labs-terraform-modules"
  buildspecs_definitions    = module.actions.buildspecs
  build_environment_variables = {
    STATE_PREFIX                       = "if2"
    TF_RECREATE_MISSING_LAMBDA_PACKAGE = "true"
  }
  terragrunt_environments = local.terragrunt_environments
  terragrunt_parallelism  = 5
}

module "github_modules_to_s3" {
  source                         = "./iac_pipeline/github-webhook-to-s3"
  resource_prefix                = "${var.resource_prefix}-modules"
  git_repo                       = "kwatatshey/labs-terraform-modules"
  codebuild_vpc_id               = var.vpc_id
  source_code_bucket_arn         = module.source_code.code_store_bucket_arn
  source_code_bucket_kms_key_arn = module.source_code.code_store_bucket_kms_key_arn
}

# module "blueprints_dev" {
#   source                            = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//source-code-bucket"
#   resource_prefix                   = var.resource_prefix
#   resource_base_name                = "-blueprints-dev-"
#   external_full_access_objects_arns = [data.aws_iam_role.blueprints_dev_syncer.arn]
#   object_ownership                  = "BucketOwnerEnforced"
#   providers = {
#     aws = aws.if2-dev
#   }
# }

# module "blueprints_prd" {
#   source                            = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//source-code-bucket"
#   resource_prefix                   = var.resource_prefix
#   resource_base_name                = "-blueprints-prd-"
#   external_full_access_objects_arns = [data.aws_iam_role.blueprints_prd_syncer.arn]
#   object_ownership                  = "BucketOwnerEnforced"
#   providers = {
#     aws = aws.if2-prd
#   }
# }

# module "github_blueprints_dev_to_s3" {
#   source                         = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//github-webhook-to-s3"
#   resource_prefix                = "${var.resource_prefix}-blueprints-dev"
#   git_repo                       = "audi-acs/acs-image-factory-image-blueprints"
#   codebuild_vpc_id               = module.network.vpc_id
#   source_code_bucket_arn         = module.blueprints_dev.code_store_bucket_arn
#   source_code_bucket_kms_key_arn = module.blueprints_dev.code_store_bucket_kms_key_arn
# }

# module "github_blueprints_prd_to_s3" {
#   source                         = "s3::https://s3-eu-central-1.amazonaws.com/if2-source-code-eu-central-1-720257828372/tags/acs-image-factory-terraform-modules/v0.6.1.zip//github-webhook-to-s3"
#   resource_prefix                = "${var.resource_prefix}-blueprints-prd"
#   git_repo                       = "audi-acs/acs-image-factory-image-blueprints"
#   codebuild_vpc_id               = module.network.vpc_id
#   source_code_bucket_arn         = module.blueprints_prd.code_store_bucket_arn
#   source_code_bucket_kms_key_arn = module.blueprints_prd.code_store_bucket_kms_key_arn
# }
