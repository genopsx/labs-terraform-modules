resource "aws_iam_role" "codepipeline" {
  name               = "${local.resource_prefix}-codepipeline"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "codepipeline_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}


# STORMTASK replace it with something custom and more restricted
resource "aws_iam_role_policy_attachment" "codepipeline_codepipeline_svc" {
  role       = aws_iam_role.codepipeline.id
  policy_arn = data.aws_iam_policy.codepipelinefullaccess.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_buckets" {
  role       = aws_iam_role.codepipeline.id
  policy_arn = aws_iam_policy.codepipeline_buckets.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild" {
  role       = aws_iam_role.codepipeline.id
  policy_arn = aws_iam_policy.codepipeline_codebuild.arn
}

resource "aws_iam_role_policy_attachment" "codepipeline_codestar" {
  count      = var.source_code_origin == "GitHub" ? 1 : 0
  role       = aws_iam_role.codepipeline.id
  policy_arn = aws_iam_policy.codepipeline_codestar[0].arn
}

resource "aws_iam_policy" "codepipeline_buckets" {
  name   = "${local.resource_prefix}-codepipeline-buckets"
  policy = data.aws_iam_policy_document.codepipeline_buckets.json
  tags   = var.tags
}

resource "aws_iam_policy" "codepipeline_codebuild" {
  name   = "${local.resource_prefix}-codepipeline-codebuild"
  policy = data.aws_iam_policy_document.codepipeline_codebuild.json
  tags   = var.tags
}

resource "aws_iam_policy" "codepipeline_codestar" {
  count  = var.source_code_origin == "GitHub" ? 1 : 0
  name   = "${local.resource_prefix}-codepipeline-codestar"
  policy = data.aws_iam_policy_document.codepipeline_codestar[0].json
  tags   = var.tags
}

data "aws_iam_policy_document" "codepipeline_buckets" {
  source_policy_documents = [templatefile("${path.module}/templates/codepipeline-store-policies.tpl",
    {
      code_store_arn          = data.aws_s3_bucket.code_store.arn
      code_store_kms_arn      = var.source_code_bucket_kms_key_arn != "" ? data.aws_kms_key.source_code_bucket_kms_key[0].arn : ""
      artefacts_store_arn     = module.artefacts_store.s3_bucket_arn
      artefacts_store_kms_arn = aws_kms_key.codepipeline_encryption.arn

    })
  ]
}

data "aws_iam_policy_document" "codepipeline_codebuild" {
  source_policy_documents = [templatefile("${path.module}/templates/codepipeline-codebuild-policy.tpl",
    {
      codebuild_projects = jsonencode([for pr in var.build_projects : aws_codebuild_project.terraform[pr].arn])
    })
  ]
}

data "aws_iam_policy_document" "codepipeline_codestar" {
  count = var.source_code_origin == "GitHub" ? 1 : 0
  source_policy_documents = [templatefile("${path.module}/templates/codestar-usage-policy.tpl",
    {
      codestar_connection_arn = aws_codestarconnections_connection.codestar_connection[0].arn
    })
  ]
}

data "aws_iam_policy" "codepipelinefullaccess" {
  arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}
