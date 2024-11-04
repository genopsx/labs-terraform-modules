locals {
  codebuild_subnet_arns           = [for k, v in data.aws_subnet.codebuild : v.arn]
  codebuild_cloudwatch_group_name = "/aws/codebuild/${local.resource_prefix}"
}

data "aws_subnet" "codebuild" {
  for_each = toset(data.aws_subnets.codebuild.ids)
  id       = each.value
}

resource "aws_codebuild_project" "terraform" {
  for_each             = toset(var.build_projects)
  name                 = "${local.resource_prefix}-codepipeline-terragrunt-${each.key}"
  service_role         = aws_iam_role.codebuild.arn
  resource_access_role = aws_iam_role.codebuild.arn
  project_visibility   = "PRIVATE"
  tags                 = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = var.compute_type
    image        = "devopsinfra/docker-terragrunt:${var.terragrunt_version}"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "TF_INPUT"
      value = "false"
    }

    environment_variable {
      name  = "STATE_PREFIX"
      value = local.state_resource_prefix
    }

    environment_variable {
      name  = "TERRAGRUNT_PARALLELISM"
      value = var.terragrunt_parallelism
    }

    environment_variable {
      name  = "TF_IN_AUTOMATION"
      value = "true"
    }

    dynamic "environment_variable" {
      for_each = var.build_environment_variables
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspecs_definitions[each.key]
  }

  ## optional

  encryption_key = aws_kms_alias.codepipeline_encryption.arn

  cache {
    type     = "S3"
    location = module.codebuild_cache.s3_bucket_id
  }

  vpc_config {
    vpc_id             = data.aws_vpc.codebuild.id
    subnets            = keys(data.aws_subnet.codebuild)
    security_group_ids = [data.aws_security_group.codebuild.id]
  }

  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = local.codebuild_cloudwatch_group_name
      stream_name = local.codebuild_cloudwatch_group_name
    }
    s3_logs {
      status = "DISABLED"
    }
  }
}
