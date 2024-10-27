locals {
  custom_kms_key_gh_token = var.use_custom_kms_key_for_token == true ? 1 : 0
}

resource "random_password" "github_token" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  keepers = {
    resource_prefix = local.resource_prefix
  }
}

resource "aws_secretsmanager_secret" "github_token" {
  name                           = "${local.resource_prefix}/github-token"
  description                    = "The secret token for the GitHub webhook"
  force_overwrite_replica_secret = true
  recovery_window_in_days        = 0
  kms_key_id                     = local.custom_kms_key_gh_token == 1 ? aws_kms_key.github_token[0].id : null
  tags                           = var.tags
}

resource "aws_secretsmanager_secret_version" "github_token" {
  secret_id     = aws_secretsmanager_secret.github_token.id
  secret_string = random_password.github_token.result
}

resource "aws_kms_key" "github_token" {
  count                    = local.custom_kms_key_gh_token
  description              = "KMS key for the GitHub token"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 7
  tags                     = var.tags
}

resource "aws_kms_alias" "github_token" {
  count         = local.custom_kms_key_gh_token
  target_key_id = aws_kms_key.github_token[0].id
  name          = "alias/${local.resource_prefix}-github-token"
}

resource "aws_kms_key_policy" "github_token" {
  count  = local.custom_kms_key_gh_token
  key_id = aws_kms_key.github_token[0].id
  policy = jsonencode({
    Id      = "KMSKeyPolicyForGitHubSecretToken"
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "Enable IAM User Permissions"
        Action   = "kms:*"
        Effect   = "Allow"
        Resource = "*"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      }
    ]
  })
}
