output "codebuild_role_name" {
  description = "The name of the CodeBuild role"
  value       = aws_iam_role.codebuild_git2s3.id
}
