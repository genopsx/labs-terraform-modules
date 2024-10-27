resource "aws_iam_role" "codebuild_git2s3" {
  name               = "${local.resource_prefix}-codebuild-github2s3"
  description        = "Service role for GitHub webhook's CodeBuild."
  assume_role_policy = data.aws_iam_policy_document.codebuild_git2s3_assume_role.json
}

resource "aws_iam_role_policy_attachment" "codebuild_git2s3" {
  role       = aws_iam_role.codebuild_git2s3.id
  policy_arn = aws_iam_policy.codebuild_git2s3.arn
}

resource "aws_iam_policy" "codebuild_git2s3" {
  name   = "${local.resource_prefix}-codebuild-github2s3"
  policy = data.aws_iam_policy_document.codebuild_git2s3.json
  tags   = var.tags
}

data "aws_iam_policy_document" "codebuild_git2s3_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "codebuild_git2s3" {
  source_policy_documents = [templatefile("${path.module}/templates/codebuild-policy.tpl",
    {
      log_group          = local.codebuild_cloudwatch_group_name
      code_store_arn     = var.source_code_bucket_arn
      code_store_kms_arn = var.source_code_bucket_kms_key_arn != "" ? var.source_code_bucket_kms_key_arn : ""
      vpc_arn            = data.aws_vpc.codebuild.arn
      subnet_arns        = local.codebuild_subnet_arns
      iface_resource     = join(":", slice(split(":", data.aws_vpc.codebuild.arn), 3, 5))
    })
  ]
}
