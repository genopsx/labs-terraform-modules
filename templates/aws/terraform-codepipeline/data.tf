data "aws_vpc" "codebuild" {
  id = var.codebuild_vpc_id
}

data "aws_subnets" "codebuild" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.codebuild.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_security_group" "codebuild" {
  vpc_id = data.aws_vpc.codebuild.id
  name   = "default"
}

data "aws_kms_key" "source_code_bucket_kms_key" {
  count  = var.source_code_bucket_kms_key_arn != "" ? 1 : 0
  key_id = var.source_code_bucket_kms_key_arn
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
