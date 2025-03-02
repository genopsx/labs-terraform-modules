# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.resource_prefix}-states-${var.iac}-${var.account_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  tags   = local.tags
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.terraform_state_key.id
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.resource_prefix}-locks-${var.iac}-${var.account_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

resource "aws_iam_role" "terraform_role" {
  name        = "${var.resource_prefix}-${var.iac}-${var.account_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  description = "Role to execute ${var.iac} in account ${var.account_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.terraform_trusted_arns
        }
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow"
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = var.oidc_audience
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.github_org}/${var.repository_1}:*",
              "repo:${var.github_org}/${var.repository_2}:*",
            ]
          }
        }
      }
    ]
  })

  tags = local.tags
}


resource "aws_iam_role_policy_attachment" "power_user_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role       = aws_iam_role.terraform_role.name
}

resource "aws_iam_role_policy_attachment" "iam_full_access_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  role       = aws_iam_role.terraform_role.name
}

resource "aws_iam_policy" "policy" {
  name        = "ci-github-oidc-TerraformStatePolicy-${var.resource_prefix}"
  description = "Policy to allow CI to access Terraform state"
  policy      = data.aws_iam_policy_document.custom_policy.json
}

resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.terraform_role.name
}


resource "aws_kms_key" "terraform_state_key" {
  description              = "KMS for the encryption of the Terraform state bucket"
  enable_key_rotation      = true
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 30
  multi_region             = false

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = var.terraform_trusted_arns
        }
        Action = [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:ScheduleKeyDeletion",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:CancelKeyDeletion"
        ]
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = concat(var.terraform_trusted_arns, [aws_iam_role.terraform_role.arn])
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "Allow attachment of persistent resources"
        Effect = "Allow"
        Principal = {
          AWS = concat(var.terraform_trusted_arns, [aws_iam_role.terraform_role.arn])
        }
        Action = [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ]
        Resource = "*"
        Condition = {
          Bool = {
            "kms:GrantIsForAWSResource" = "true"
          }
        }
      }
    ]
  })
  tags = local.tags
}

resource "aws_kms_alias" "terraform_state_key_alias" {
  name          = "alias/${var.resource_prefix}-stateskey-${var.iac}-${var.account_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  target_key_id = aws_kms_key.terraform_state_key.key_id
}


