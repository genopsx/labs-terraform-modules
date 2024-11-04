# Introducing multi-region pipelines, see https =//github.com/audi-acs/acs-image-factory-iac-pipeline/pull/13

# moved {
#   from = module.terraform_codepipeline.aws_kms_key_policy.terraform_state
#   to   = module.tf_state_eu_central_1.aws_kms_key_policy.terraform_state
# }

# moved {
#   from = module.terraform_codepipeline.aws_kms_key.terraform_state
#   to   = module.tf_state_eu_central_1.aws_kms_key.terraform_state
# }

# moved {
#   from = module.terraform_codepipeline.aws_s3_bucket.tf_state_store
#   to   = module.tf_state_eu_central_1.aws_s3_bucket.tf_state_store
# }
