data "aws_region" "current" {}

locals {
  ecr_repository_arn = "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${var.build_ecr_repository_name}"
}

data "aws_iam_policy_document" "ecr_pull" {
  statement {
    effect = "Allow"

    actions = [
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]

    resources = [local.ecr_repository_arn]
  }
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt"
    ]

    resources = [
      var.build_ecr_repository_kms_arn
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    resources = ["arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }

    condition {
      test     = "ArnEquals"
      variable = "ec2:Subnet"
      values   = var.vpc_private_subnet_arns
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

locals {
  secret_arns = distinct([
    for secret in var.codebuild_secrets_manager_access : "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${secret.alias}-??????"
  ])
}

data "aws_iam_policy_document" "secrets_manager_access" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    resources = local.secret_arns
  }
}

resource "aws_iam_role_policy" "secrets_manager_access" {
  name   = "${var.codebuild_project_name}-secrets-manager-access"
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.secrets_manager_access.json
}


resource "aws_iam_role" "codebuild" {
  name               = "${var.codebuild_project_name}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "ecr_pull" {
  name   = "${var.codebuild_project_name}-ecr-pull"
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.ecr_pull.json
}

resource "aws_iam_role_policy" "codebuild" {
  name   = "${var.codebuild_project_name}-codebuild-permissions"
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.codebuild.json
}
