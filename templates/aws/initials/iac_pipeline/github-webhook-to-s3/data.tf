
data "aws_vpc" "codebuild" {
  id = var.codebuild_vpc_id
}

data "aws_subnet" "codebuild" {
  for_each = toset(data.aws_subnets.codebuild.ids)
  id       = each.value
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
