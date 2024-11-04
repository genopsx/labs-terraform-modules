output "code_store_bucket_id" {
  value = module.source_code_bucket.s3_bucket_id
}

output "code_store_bucket_arn" {
  value = module.source_code_bucket.s3_bucket_arn
}

output "code_store_bucket_kms_key_arn" {
  value = var.use_custom_kms_key == true ? aws_kms_key.source_code_bucket[0].arn : ""
}
