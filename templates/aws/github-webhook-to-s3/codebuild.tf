locals {
  codebuild_project_name          = "${local.resource_prefix}-codebuild-github2s3-${local.repo_name}"
  codebuild_subnet_arns           = [for k, v in data.aws_subnet.codebuild : v.arn]
  codebuild_cloudwatch_group_name = var.codebuild_cloudwatch_group_name != null ? var.codebuild_cloudwatch_group_name : local.codebuild_project_name
  bucket_id                       = element(split(":", var.source_code_bucket_arn), 5)
}

resource "aws_codebuild_webhook" "github_fetch" {
  count        = var.create_github_webhook == true ? 1 : 0
  project_name = aws_codebuild_project.git2s3.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
  }
}

resource "aws_codebuild_project" "git2s3" {
  name                 = local.codebuild_project_name
  service_role         = aws_iam_role.codebuild_git2s3.arn
  resource_access_role = aws_iam_role.codebuild_git2s3.arn
  project_visibility   = "PRIVATE"
  tags                 = var.tags
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = var.build_compute_type
    image        = var.build_image
    environment_variable {
      name  = "output_bucket"
      value = local.bucket_id
    }
    environment_variable {
      name  = "deployment_branches"
      value = join(" ", var.deployment_branches)
    }
    environment_variable {
      name  = "deployment_file_name"
      value = var.deployment_file_name
    }
    environment_variable {
      name  = "merge_requests_file_name"
      value = var.merge_requests_file_name
    }
    environment_variable {
      name  = "include_git_metadata"
      value = var.include_git_metadata
    }
    privileged_mode = false
    type            = "LINUX_CONTAINER"
  }
  source {
    buildspec       = var.use_as_pipeline_trigger ? file("${path.module}/buildspecs/pipeline_trigger.yml") : file("${path.module}/buildspecs/store_in_s3.yml")
    type            = "GITHUB"
    location        = "https://github.com/${var.git_repo}.git"
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = false
    }
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
