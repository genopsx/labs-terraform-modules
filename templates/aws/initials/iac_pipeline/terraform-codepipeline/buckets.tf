#
# Codepipeline code store
#
data "aws_s3_bucket" "code_store" {
  bucket = var.source_code_bucket_id
}

#tfsec:ignore:aws-s3-encryption-customer-key
module "artefacts_store" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "3.15.1"
  bucket                   = "${local.resource_prefix}-artefacts-store-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  attach_policy            = true
  policy                   = data.aws_iam_policy_document.artefacts_store_restrictions.json
  force_destroy            = var.force_destroy_buckets
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.codepipeline_encryption.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = var.tags

  lifecycle_rule = [
    {
      id      = "delete-old-versions"
      status  = "Enabled"
      prefix  = ""
      enabled = true

      expiration = {
        days = var.expiration_days_artefacts
      }
    }
  ]
}

data "aws_iam_policy_document" "artefacts_store_restrictions" {
  source_policy_documents = [
    templatefile(
      "${path.module}/templates/artefacts-store-policy.tpl",
      {
        artefacts_store_arn = module.artefacts_store.s3_bucket_arn
      },
    ),
  ]
}

#tfsec:ignore:aws-s3-encryption-customer-key
module "codebuild_cache" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "3.15.1"
  bucket                   = "${local.resource_prefix}-codebuild-cache-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  force_destroy            = var.force_destroy_buckets

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.codepipeline_encryption.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = var.tags

  lifecycle_rule = [
    {
      id      = "delete-old-versions"
      status  = "Enabled"
      prefix  = ""
      enabled = true

      expiration = {
        days = var.expiration_days_codebuild_cache
      }
    }
  ]
}

#
# KMS key for pipeline's bucket
#
resource "aws_kms_key" "codepipeline_encryption" {
  description              = "KMS key for CodePipeline bucket encryption"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  tags                     = var.tags
}

resource "aws_kms_key_policy" "codepipeline_encryption" {
  key_id = aws_kms_key.codepipeline_encryption.id
  policy = data.aws_iam_policy_document.codepipeline_kms.json
}

resource "aws_kms_alias" "codepipeline_encryption" {
  target_key_id = aws_kms_key.codepipeline_encryption.id
  name          = "alias/${local.resource_prefix}-pipeline"
}

data "aws_iam_policy_document" "codepipeline_kms" {
  source_policy_documents = [
    templatefile(
      "${path.module}/templates/terraform-state-kms-resource-policy.tpl",
      {
        account_id = data.aws_caller_identity.current.account_id
      },
    ),
  ]
}
