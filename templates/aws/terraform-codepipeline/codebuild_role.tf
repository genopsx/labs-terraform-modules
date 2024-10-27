resource "aws_iam_role" "codebuild" {
  name               = "${local.resource_prefix}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "codebuild_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.codepipeline.arn]
    }
  }
}

resource "aws_iam_role_policy_attachment" "codebuild_logs" {
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_logs.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_vpc_usage" {
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_vpc_usage.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_buckets" {
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_buckets.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_dynamodb_table_state_lock" {
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_dynamodb_table_state_lock.arn
}

# STORMTASK replace it with something custom and more restricted
resource "aws_iam_role_policy_attachment" "codebuild_codebuild_svc" {
  role       = aws_iam_role.codebuild.id
  policy_arn = data.aws_iam_policy.codebuilddevaccess.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_terraform_state_kms_key" {
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_terraform_state_kms_key.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_sts" {
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_sts.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_codestar" {
  count      = var.source_code_origin == "GitHub" ? 1 : 0
  role       = aws_iam_role.codebuild.id
  policy_arn = aws_iam_policy.codebuild_codestar[0].arn
}

resource "aws_iam_policy" "codebuild_logs" {
  name   = "${local.resource_prefix}-codebuild-logs"
  policy = data.aws_iam_policy_document.codebuild_logs.json
  tags   = var.tags
}

resource "aws_iam_policy" "codebuild_vpc_usage" {
  name   = "${local.resource_prefix}-codebuild-vpc-usage"
  policy = data.aws_iam_policy_document.codebuild_vpc_usage.json
  tags   = var.tags
}

resource "aws_iam_policy" "codebuild_buckets" {
  name   = "${local.resource_prefix}-codebuild-buckets"
  policy = data.aws_iam_policy_document.codebuild_buckets.json
  tags   = var.tags
}

resource "aws_iam_policy" "codebuild_dynamodb_table_state_lock" {
  name   = "${local.resource_prefix}-codebuild-dynamodb-table-state-lock"
  policy = data.aws_iam_policy_document.codebuild_dynamodb_table_state_lock.json
  tags   = var.tags
}

resource "aws_iam_policy" "codebuild_terraform_state_kms_key" {
  name   = "${local.resource_prefix}-codebuild-terraform-state-kms-key"
  policy = data.aws_iam_policy_document.codebuild_terraform_state_kms_key.json
  tags   = var.tags
}

resource "aws_iam_policy" "codebuild_sts" {
  name   = "${local.resource_prefix}-codebuild-sts"
  policy = data.aws_iam_policy_document.codebuild_sts.json
  tags   = var.tags
}

resource "aws_iam_policy" "codebuild_codestar" {
  count  = var.source_code_origin == "GitHub" ? 1 : 0
  name   = "${local.resource_prefix}-codebuild-codestar"
  policy = data.aws_iam_policy_document.codebuild_codestar[0].json
  tags   = var.tags
}

data "aws_iam_policy_document" "codebuild_logs" {
  source_policy_documents = [templatefile("${path.module}/templates/codebuild-logs-policies.tpl",
    {
      log_group = local.codebuild_cloudwatch_group_name
    })
  ]
}

data "aws_iam_policy_document" "codebuild_vpc_usage" {
  source_policy_documents = [templatefile("${path.module}/templates/codebuild-vpc-policies.tpl",
    {
      vpc_arn        = data.aws_vpc.codebuild.arn
      subnet_arns    = local.codebuild_subnet_arns
      iface_resource = join(":", slice(split(":", data.aws_vpc.codebuild.arn), 3, 5))
    })
  ]
}

data "aws_iam_policy_document" "codebuild_buckets" {
  source_policy_documents = [templatefile("${path.module}/templates/codebuild-store-policies.tpl",
    {
      code_store_kms_arn         = var.source_code_bucket_kms_key_arn != "" ? data.aws_kms_key.source_code_bucket_kms_key[0].arn : ""
      codepipeline_store_kms_arn = aws_kms_key.codepipeline_encryption.arn
      code_store_arn             = data.aws_s3_bucket.code_store.arn
      all_buckets_arns = jsonencode(flatten([
        [data.aws_s3_bucket.code_store.arn,
          module.codebuild_cache.s3_bucket_arn,
        module.artefacts_store.s3_bucket_arn],
        var.terraform_state_buckets_arns
      ]))
      read_write_paths = jsonencode(flatten([
        ["${module.codebuild_cache.s3_bucket_arn}/*",
        "${module.artefacts_store.s3_bucket_arn}/*"],
        [for b in var.terraform_state_buckets_arns : "${b}/*"]
      ]))
    })
  ]
}

data "aws_iam_policy_document" "codebuild_dynamodb_table_state_lock" {
  source_policy_documents = [templatefile("${path.module}/templates/dynamodb-table-policies.tpl",
    {
      terraform_state_dynamodb_tables_arns = jsonencode(var.terraform_state_dynamodb_arns)
    })
  ]
}

data "aws_iam_policy_document" "codebuild_terraform_state_kms_key" {
  source_policy_documents = [templatefile("${path.module}/templates/terraform-state-kms-usage-policy.tpl",
    {
      terraform_state_keys_arns = jsonencode(var.terraform_state_buckets_kms_keys_arns)
    })
  ]
}

data "aws_iam_policy_document" "codebuild_sts" {
  source_policy_documents = [templatefile("${path.module}/templates/codebuild-sts-policy.tpl",
    {
      workload_roles_arns = jsonencode(distinct([for k, v in var.terragrunt_environments : v["workload_role_arn"]]))
    })
  ]
}

data "aws_iam_policy_document" "codebuild_codestar" {
  count = var.source_code_origin == "GitHub" ? 1 : 0
  source_policy_documents = [templatefile("${path.module}/templates/codestar-usage-policy.tpl",
    {
      codestar_connection_arn = aws_codestarconnections_connection.codestar_connection[0].arn
    })
  ]
}

data "aws_iam_policy" "codebuilddevaccess" {
  arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}
