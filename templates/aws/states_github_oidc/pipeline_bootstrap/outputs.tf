output "terraform_state_bucket_id" {
  value = aws_s3_bucket.terraform_state.id
}

output "terraform_state_lock_id" {
  value = aws_dynamodb_table.terraform_locks.id
}

output "terraform_role_id" {
  value = aws_iam_role.terraform_role.id
}
