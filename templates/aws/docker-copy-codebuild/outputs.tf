output "codebuild_project_arn" {
  value = aws_codebuild_project.image-builder.id
}

output "codebuild_iam_role_arn" {
  value = aws_iam_role.codebuild.arn
}