output "state_bucket_arn" {
  description = "The ARN of the Terraform state bucket"
  value       = aws_s3_bucket.tf_state_store.arn
}

output "state_dynamodb_lock_arn" {
  description = "The ARN of the Dynamo DB tables that locks the Terraform state"
  value       = aws_dynamodb_table.tf_state_lock.arn
}

output "state_kms_arn" {
  description = "The ARN of the KMS keys that encrypts the Terraform state bucket"
  value       = aws_kms_key.terraform_state.arn
}

output "terraform_state_resources_prefix" {
  description = "The prefix common to all the names of the resources (S3 bucket, KMS key and DynamoDB table) dedicated to host the Terraform / Terragrunt states"
  value       = local.state_resource_prefix
}
