resource "helm_release" "ecr_cleanup" {
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version
  name             = var.release_name
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "ecr-cleanup"
  values           = [local.base_values]
  wait             = true # Wait for the deployment to be ready before marking the resource as complete
}


module "ecr_cleanup_irsa_role" {
  source           = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version          = "5.52.2"
  create_role      = true
  role_name_prefix = "ecr-cleanup"

  role_policy_arns = {
    policy = aws_iam_policy.ecr_cleanup_policy.arn
  }
  oidc_providers = {
    ex = {
      provider_arn               = var.cluster_oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:ecr-cleanup"]
    }
  }
  depends_on = [aws_iam_policy.ecr_cleanup_policy]
}

# Create IAM Policy for ECR cleanup actions
resource "aws_iam_policy" "ecr_cleanup_policy" {
  name        = "ECRCleanupPolicy"
  description = "Policy for ECR cleanup actions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ECRCleanupPolicy"
        Effect = "Allow"
        Action = [
          "ecr:BatchDeleteImage",
          "ecr:BatchGetImage",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:ListImages"
        ]
        Resource = "*"
      }
    ]
  })
}

# If using an external role, attach the policy manually (example for existing IAM role):
resource "aws_iam_role_policy_attachment" "ecr_cleanup_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_cleanup_policy.arn
  role       = module.ecr_cleanup_irsa_role.iam_role_name
}
