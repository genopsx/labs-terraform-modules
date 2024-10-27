resource "aws_kms_key" "terraform_state" {
  description              = "Terraform state bucket encryption"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  tags                     = var.tags
}

resource "aws_kms_key_policy" "terraform_state" {
  key_id = aws_kms_key.terraform_state.id
  policy = data.aws_iam_policy_document.terraform_state_kms.json
}

resource "aws_kms_alias" "terraform_state" {
  target_key_id = aws_kms_key.terraform_state.id
  name          = "alias/${local.state_resource_prefix}-${data.aws_region.current.name}-terraform"
}

resource "aws_s3_bucket" "tf_state_store" {
  bucket        = "${local.state_resource_prefix}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  force_destroy = var.force_destroy_buckets
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "tf_state_store" {
  bucket = aws_s3_bucket.tf_state_store.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.tf_state_store.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_dynamodb_table" "tf_state_lock" {
  name         = "${local.state_resource_prefix}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  tags         = var.tags
  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_iam_policy_document" "terraform_state_kms" {
  source_policy_documents = [templatefile("${path.module}/templates/terraform-state-kms-resource-policy.tpl",
    {
      account_id = data.aws_caller_identity.current.account_id
    })
  ]
}
