variable "s3_bucket_id" {
  type        = string
  description = "The ID of the S3 bucket"
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 Objects"
}

variable "s3_bucket_objects_key" {
  type        = string
  description = "The key of the object in the S3 bucket"
}

variable "s3_bucket_objects_content" {
  type        = string
  description = "The content of the object in the S3 bucket"
}

variable "s3_bucket_objects_content_type" {
  type        = string
  description = "The content type of the object in the S3 bucket"
}

variable "s3_bucket_objects_etag" {
  type        = string
  description = "The ETag of the object in the S3 bucket"
}
