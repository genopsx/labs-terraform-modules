#trivy:ignore:*
#trivy:ignore:AVD-AWS-0089
module "source_code_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "3.15.1"
  force_destroy            = var.force_destroy_buckets
  bucket                   = local.resource_name
  acl                      = var.object_ownership == "BucketOwnerEnforced" ? null : var.acl
  control_object_ownership = true
  object_ownership         = var.object_ownership
  tags                     = var.tags
  attach_policy            = length(var.external_full_access_objects_arns) > 0
  policy                   = length(var.external_full_access_objects_arns) > 0 ? data.aws_iam_policy_document.source_code_bucket_resource[0].json : null
  versioning = {
    enabled = var.enable_versioning
  }
  lifecycle_rule = [
    {
      id = "delete-branches-folder-contents"
      filter = {
        prefix = "branches/"
      }

      enabled = true
      expiration = {
        days = var.branches_folder_lifetime_days
      }
    },
    {
      id      = "delete-old-versions"
      enabled = var.enable_versioning
      filter  = {}  # Ensure a filter is provided to apply rule globally
      noncurrent_version_expiration = {
        noncurrent_days = var.max_days_noncurrent_version_lifetime
    }
  ]
  server_side_encryption_configuration = var.use_custom_kms_key == true ? {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.source_code_bucket[0].arn
        sse_algorithm     = "aws:kms"
      }
    }
  } : {}
}

data "aws_iam_policy_document" "source_code_bucket_resource" {
  count = length(var.external_full_access_objects_arns) > 0 ? 1 : 0
  source_policy_documents = [templatefile("${path.module}/templates/source-code-bucket-resource-policy.tpl",
    {
      principal_arns = jsonencode(var.external_full_access_objects_arns)
      bucket_name    = local.resource_name
    })
  ]
}

resource "aws_kms_key" "source_code_bucket" {
  count                    = var.use_custom_kms_key == true ? 1 : 0
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  description              = "KMS key used to encrypt the ${local.resource_name} bucket"
  deletion_window_in_days  = 7
  enable_key_rotation      = true
}

resource "aws_kms_alias" "source_code_bucket" {
  count         = var.use_custom_kms_key == true ? 1 : 0
  target_key_id = aws_kms_key.source_code_bucket[0].id
  name          = "alias/${local.resource_name}"
}

resource "aws_kms_key_policy" "source_code_bucket" {
  count  = var.use_custom_kms_key == true ? 1 : 0
  key_id = aws_kms_key.source_code_bucket[0].id
  policy = data.aws_iam_policy_document.source_code_kms[0].json
}

data "aws_iam_policy_document" "source_code_kms" {
  count = var.use_custom_kms_key == true ? 1 : 0
  source_policy_documents = [templatefile("${path.module}/templates/source-code-kms-resource-policy.tpl",
    {
      account_id              = data.aws_caller_identity.current.account_id
      external_principal_arns = length(var.external_full_access_objects_arns) > 0 ? jsonencode(var.external_full_access_objects_arns) : ""
    })
  ]
}

resource "aws_s3_bucket_notification" "source_code_bucket" {
  bucket      = module.source_code_bucket.s3_bucket_id
  eventbridge = true
}
