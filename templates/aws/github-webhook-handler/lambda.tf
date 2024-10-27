locals {
  compatible_runtime = "python3.8"
}

module "handler" {
  source                     = "terraform-aws-modules/lambda/aws"
  version                    = "5.3.0"
  function_name              = "${local.resource_prefix}-github-webhook-handler"
  description                = "Handle the GitHub webhook calls"
  handler                    = "app.lambda_handler"
  runtime                    = local.compatible_runtime
  compatible_runtimes        = [local.compatible_runtime]
  policy_json                = data.aws_iam_policy_document.github_webhook_handler.json
  attach_policy_json         = true
  timeout                    = 100
  authorization_type         = "NONE"
  create_lambda_function_url = true
  environment_variables = {
    EVENT_BUS_NAME            = local.cloudwatch_event_bus.name
    GITHUB_WEBHOOK_SECRET_ARN = aws_secretsmanager_secret.github_token.arn
  }
  create_layer   = false
  create_package = false
  s3_existing_package = {
    bucket = "${var.lambda_source_bucket_prefix}-${data.aws_region.current.name}"
    key    = var.lambda_source_file_path
  }
}

resource "aws_cloudwatch_metric_alarm" "github_webhook_handler_invocations" {
  alarm_name          = "GitHubWebhook-Lambda-Invocation-Alarm-${local.resource_prefix}"
  alarm_description   = "Alarm for GitHubWebhook ${local.resource_prefix} Lambda for traffic spikes"
  metric_name         = "Incovations"
  namespace           = "AWS/Lambda"
  period              = 300
  evaluation_periods  = 2
  threshold           = var.lambda_invocation_threshold
  comparison_operator = "GreaterThanThreshold"
  statistic           = "Sum"
  dimensions = {
    FunctionName = module.handler.lambda_function_name
  }
}

data "aws_iam_policy_document" "github_webhook_handler" {
  source_policy_documents = [templatefile("${path.module}/templates/github-webhook-handler-policies.tpl",
    {
      github_token_arn = aws_secretsmanager_secret.github_token.arn
      event_bus_arn    = local.cloudwatch_event_bus.arn
      kms_key_arn      = var.use_custom_kms_key_for_token == true ? aws_kms_key.github_token[0].arn : ""
    })
  ]
}
