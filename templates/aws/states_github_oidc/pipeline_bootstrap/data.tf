data "aws_iam_policy_document" "custom_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]
    effect = "Allow"
    sid    = "AllowPipelineListBucketTerraformState"
  }

  statement {
    actions = [
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]
    resources = [
      "${aws_s3_bucket.terraform_state.arn}"
    ]
    effect = "Allow"
    sid    = "AllowPipelineReadWriteTerraformState"
  }

  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      "${aws_dynamodb_table.terraform_locks.arn}"
    ]
    effect = "Allow"
    sid    = "AllowReadWriteStatusDynamoDBTable"
  }
}


# tflint-ignore: terraform_unused_declarations
data "aws_caller_identity" "current" {} # data.aws_caller_identity.current.account_id
# tflint-ignore: terraform_unused_declarations
data "aws_region" "current" {} # data.aws_region.current.name
