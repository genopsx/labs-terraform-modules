locals {
  codebuild_project_name_base     = "${local.resource_prefix}-github-ci"
  codebuild_cloudwatch_group_name = "/aws/codebuild/${local.resource_prefix}"
  # A list of environments for which the CI CodeBuild projects should be created
  ci_environments = distinct(compact([
    for k, v in var.terragrunt_environments : contains(var.skip_ci, k) ? null : k
  ]))
  # An array of objects: each object specifies an environment and a CodeBuild project to run from var.build_projects
  cb_projects = distinct(flatten([
    for e in local.ci_environments : [
      for p in var.build_projects : merge(var.terragrunt_environments[e], { env = e, task = p })
    ]
  ]))
  # Transform the above list into a hash (the key is the combination <environment>-<test name>) so that it can be consumed
  # by for_each (it can't work with a list of objects)
  cb_projects_iterator    = { for p in local.cb_projects : "${p.env}-${p.task}" => p }
  github_webhook_iterator = var.create_github_webhook == true ? keys(local.cb_projects_iterator) : []
}

resource "aws_codebuild_project" "github_codebuild_ci" {
  for_each             = local.cb_projects_iterator
  name                 = "${local.codebuild_project_name_base}-${each.key}"
  service_role         = data.aws_iam_role.github_codebuild_ci.arn
  resource_access_role = data.aws_iam_role.github_codebuild_ci.arn
  project_visibility   = "PRIVATE"
  tags                 = var.tags
  badge_enabled        = true
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type    = var.build_compute_type
    image           = "devopsinfra/docker-terragrunt:${var.terragrunt_version}"
    privileged_mode = false
    type            = "LINUX_CONTAINER"
    environment_variable {
      name  = "TF_INPUT"
      value = "false"
    }
    environment_variable {
      name  = "TERRAGRUNT_WORKING_DIR"
      value = "${each.value.base_folder}/${each.value.env}/"
    }
    environment_variable {
      name  = "TERRAFORM_ASSUMED_ROLE"
      value = each.value.workload_role_arn
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
    buildspec       = var.buildspecs_definitions[each.value.task]
    type            = "GITHUB"
    location        = "https://github.com/${var.git_repo}.git"
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = true
    }
  }
  cache {
    type     = "S3"
    location = data.aws_s3_bucket.codebuild_cache_bucket.id
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

resource "aws_codebuild_webhook" "github_trigger" {
  for_each     = toset(local.github_webhook_iterator)
  project_name = aws_codebuild_project.github_codebuild_ci[each.key].name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED"
    }
    filter {
      type                    = "HEAD_REF"
      pattern                 = "^refs/heads/(${join("|", var.deployment_branches)})$"
      exclude_matched_pattern = true
    }
  }
}
