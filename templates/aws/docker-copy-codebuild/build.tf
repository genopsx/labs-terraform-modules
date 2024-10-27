data "aws_caller_identity" "current" {}

locals {
  buildspec_template_vars = {
    env : yamlencode({
      "env" : {
        "variables" : {
          "AWS_ACCOUNT_ID" : data.aws_caller_identity.current.account_id,
          "SOURCE_ECR_REPOSITORY_NAME" : var.build_ecr_repository_name,
        },
        "secrets-manager" : length(var.codebuild_secrets_manager_access) > 0 ? {
          for secret in var.codebuild_secrets_manager_access : secret.name => "${secret.alias}:${secret.key}${secret.version_stage != null ? ":" + secret.version_stage : ""}${secret.version_id != null ? ":" + secret.version_id : ""}"
        } : {}
      }
    })
  }
}

resource "aws_codebuild_project" "image-builder" {
  name          = var.codebuild_project_name
  description   = var.codebuild_project_name
  build_timeout = var.codebuild_build_timeout
  service_role  = aws_iam_role.codebuild.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "SOURCE_ECR_IMAGE_TAG"
      value = ""
    }

    /*
    The DESTINATIONS environment variable is a JSON array of objects, each with the following:
    - repository: The name of the destination repository
    - tag: The tag to apply to the image in the destination repository
    - type: The type of the destination repository. Valid values are ecr and non-ecr.

    Example:
    [
      {
        "repository": "my-ecr-repo",
        "tag": "my-tag",
        "type": "ecr"
      },
      {
        "repository": "my-artifactory-repo",
        "tag": "my-other-tag",
        "type": "non-ecr"
      }
    ]

    Make sure the environment variable content is not stringified, for example:
    - [{"repository": "if2-dev-org-audi-dev-ecr","tag": "ubuntu2004-lts-v1.2.3-20240117164631","type": "ecr"}]
    */
    environment_variable {
      name  = "DESTINATIONS"
      value = ""
    }
  }

  source {
    type      = "NO_SOURCE"
    buildspec = templatefile("${path.module}/buildspec.yml.tftpl", local.buildspec_template_vars)
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.log_group
      stream_name = var.codebuild_project_name
    }
  }

  vpc_config {
    vpc_id = var.vpc_id

    subnets = var.vpc_private_subnet_ids

    security_group_ids = [var.vpc_default_security_group_id]
  }
}
