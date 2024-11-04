locals {
  cloudwatch_event_bus = var.custom_eventbridge_bus == true ? aws_cloudwatch_event_bus.image_factory[0] : data.aws_cloudwatch_event_bus.image_factory[0]
}

resource "aws_cloudwatch_event_bus" "image_factory" {
  count = var.custom_eventbridge_bus == true ? 1 : 0
  name  = "${local.resource_prefix}-image-factory"
  tags  = var.tags
}

data "aws_cloudwatch_event_bus" "image_factory" {
  count = var.custom_eventbridge_bus == false ? 1 : 0
  name  = "default"
}
