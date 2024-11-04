locals {
  codepipeline_name = "${local.resource_prefix}-codepipeline"
  terragrunt_action_env_vars = { for env in keys(var.terragrunt_environments) : env => [
    {
      name  = "TERRAGRUNT_WORKING_DIR"
      type  = "PLAINTEXT"
      value = "${var.terragrunt_environments[env]["base_folder"]}/${env}/"
    },
    {
      name  = "TERRAFORM_ASSUMED_ROLE"
      type  = "PLAINTEXT"
      value = var.terragrunt_environments[env]["workload_role_arn"]
    }]
  }
}

resource "aws_codestarconnections_connection" "codestar_connection" {
  count         = var.source_code_origin == "GitHub" ? 1 : 0
  name          = "${local.resource_prefix}-github"
  provider_type = var.source_code_origin
  tags          = var.tags
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${local.codepipeline_name}-deployment"
  role_arn = aws_iam_role.codepipeline.arn
  tags     = var.tags
  artifact_store {
    location = module.artefacts_store.s3_bucket_id
    type     = "S3"
    encryption_key {
      id   = aws_kms_alias.codepipeline_encryption.arn
      type = "KMS"
    }
  }
  stage {
    name = "Source"
    dynamic "action" {
      for_each = var.source_code_origin == "GitHub" ? toset([1]) : toset([])
      content {
        category         = "Source"
        owner            = "AWS"
        name             = "FetchCodeFromGitHub"
        provider         = "CodeStarSourceConnection"
        version          = "1"
        input_artifacts  = []
        output_artifacts = ["sourcecode"]
        configuration = {
          FullRepositoryId     = var.source_code_github_repo
          BranchName           = var.source_code_github_branch
          ConnectionArn        = aws_codestarconnections_connection.codestar_connection[0].arn
          OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        }
        role_arn  = aws_iam_role.codepipeline.arn
        run_order = 1
      }
    }
    dynamic "action" {
      for_each = var.source_code_origin == "S3" ? toset([1]) : toset([])
      content {
        category         = "Source"
        owner            = "AWS"
        name             = "FetchCodeFromS3"
        provider         = "S3"
        version          = "1"
        input_artifacts  = []
        output_artifacts = ["sourcecode"]
        configuration = {
          S3Bucket             = data.aws_s3_bucket.code_store.id
          S3ObjectKey          = "${trimsuffix(var.source_code_base_path, "/")}/${var.source_code_deployment_file_name}"
          PollForSourceChanges = false
        }
        role_arn  = aws_iam_role.codepipeline.arn
        run_order = 1
      }
    }
  }

  dynamic "stage" {
    for_each = var.terragrunt_environments
    content {
      name = stage.key
      action {
        category        = "Build"
        owner           = "AWS"
        name            = "TerragruntFormat"
        provider        = "CodeBuild"
        version         = "1"
        input_artifacts = ["sourcecode"]
        configuration = {
          ProjectName          = aws_codebuild_project.terraform["validate"].name
          EnvironmentVariables = jsonencode(local.terragrunt_action_env_vars[stage.key])
        }
        run_order = 1
      }
      action {
        category         = "Build"
        owner            = "AWS"
        name             = "TerragruntPlan"
        provider         = "CodeBuild"
        version          = "1"
        input_artifacts  = ["sourcecode"]
        output_artifacts = ["tfplan${stage.key}"]
        configuration = {
          ProjectName          = aws_codebuild_project.terraform["plan"].name
          EnvironmentVariables = jsonencode(local.terragrunt_action_env_vars[stage.key])
        }
        role_arn  = aws_iam_role.codebuild.arn
        run_order = 2
      }
      dynamic "action" {
        for_each = stage.value["apply_changes"] == "manual" ? toset([1]) : toset([])
        content {
          category         = "Approval"
          owner            = "AWS"
          name             = "TerragruntApprove"
          provider         = "Manual"
          version          = "1"
          input_artifacts  = []
          output_artifacts = []
          configuration = {
            CustomData = "Please review and approve the Terragrunt apply operation"
          }
          run_order = 3
        }
      }
      dynamic "action" {
        for_each = length(regexall("(auto|manual)", stage.value["apply_changes"])) > 0 ? toset([1]) : toset([])
        content {
          category         = "Build"
          owner            = "AWS"
          name             = "TerragruntApply"
          provider         = "CodeBuild"
          version          = "1"
          input_artifacts  = ["tfplan${stage.key}"]
          output_artifacts = []
          configuration = {
            ProjectName          = aws_codebuild_project.terraform["apply"].name
            EnvironmentVariables = jsonencode(local.terragrunt_action_env_vars[stage.key])
          }
          role_arn  = aws_iam_role.codebuild.arn
          run_order = 4
        }
      }
    }
  }
}
