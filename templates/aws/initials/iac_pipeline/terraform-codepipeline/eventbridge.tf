locals {
  eventbridge_counter = var.source_code_origin == "S3" ? 1 : 0
}

data "aws_cloudwatch_event_bus" "default" {
  name = "default"
}

resource "aws_iam_role" "eventbridge_role" {
  count              = local.eventbridge_counter
  name               = "${local.resource_prefix}-eventbridge-role"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_trust.json
}

data "aws_iam_policy_document" "eventbridge_trust" {
  dynamic "statement" {
    for_each = local.eventbridge_counter == 1 ? toset([1]) : toset([])
    content {
      effect  = "Allow"
      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = ["events.amazonaws.com"]
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "eventbridge_codepipeline_policy" {
  count      = local.eventbridge_counter
  role       = aws_iam_role.eventbridge_role[0].name
  policy_arn = aws_iam_policy.eventbridge_codepipeline_policy[0].arn
}

resource "aws_iam_policy" "eventbridge_codepipeline_policy" {
  count       = local.eventbridge_counter
  description = "Allow Eventbridge to trigger CodePipeline"
  name        = "${local.resource_prefix}-eventbridge-policy-for-codepipeline"
  policy      = data.aws_iam_policy_document.eventbridge_codepipeline_policy.json
}

data "aws_iam_policy_document" "eventbridge_codepipeline_policy" {
  dynamic "statement" {
    for_each = local.eventbridge_counter == 1 ? toset([1]) : toset([])
    content {
      effect    = "Allow"
      actions   = ["codepipeline:StartPipelineExecution"]
      resources = [aws_codepipeline.codepipeline.arn]
    }
  }
}

resource "aws_cloudwatch_event_rule" "codepipeline_trigger" {
  count       = local.eventbridge_counter
  name        = "${local.resource_prefix}-codepipeline-eventbridge-rule-deployment"
  description = "Created object in the bucket ${data.aws_s3_bucket.code_store.id} for deployment pipeline"
  event_pattern = templatefile("${path.module}/templates/source-code-event-rule.tpl", {
    bucket_id   = data.aws_s3_bucket.code_store.id
    object_path = aws_codepipeline.codepipeline.stage[0].action[0].configuration["S3ObjectKey"]
  })
  event_bus_name = data.aws_cloudwatch_event_bus.default.name
  role_arn       = aws_iam_role.eventbridge_role[0].arn
}

resource "aws_cloudwatch_event_target" "codepipeline_trigger" {
  count          = local.eventbridge_counter
  rule           = aws_cloudwatch_event_rule.codepipeline_trigger[0].name
  target_id      = aws_codepipeline.codepipeline.id
  arn            = aws_codepipeline.codepipeline.arn
  event_bus_name = data.aws_cloudwatch_event_bus.default.name
  role_arn       = aws_iam_role.eventbridge_role[0].arn
}
