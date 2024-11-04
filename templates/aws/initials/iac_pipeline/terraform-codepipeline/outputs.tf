output "codebuild_role_name" {
  description = "The name of the CodeBuild role"
  value       = aws_iam_role.codebuild.name
}

output "codebuild_cache_bucket_id" {
  description = "The ID of the CodeBuild cache bucket"
  value       = module.codebuild_cache.s3_bucket_id
}

output "artefacts_bucket_id" {
  description = "The ID of the CodeBuild artefacts bucket"
  value       = module.artefacts_store.s3_bucket_id
}

output "buckets_kms_key_id" {
  description = "The if of the KMS key that encrypts the cache and artefacts buckets"
  value       = aws_kms_key.codepipeline_encryption.id
}

output "codepipeline_name" {
  description = "The name of the deployment CodePipeline"
  value       = aws_codepipeline.codepipeline.name
}
