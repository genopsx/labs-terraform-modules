data "aws_route53_zone" "parent_hosted_zone" {
  name = var.r53_hosted_zone_name
}

