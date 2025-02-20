#------------------------------------------------------------------------------
# S3 BUCKET OBJECTS CONFIGURATION
#------------------------------------------------------------------------------
module "s3_bucket_objects" {
  source       = "terraform-aws-modules/s3-bucket/aws//modules/object"
  version      = "4.6.0"
  bucket       = var.s3_bucket_id
  acl          = var.acl
  key          = var.s3_bucket_objects_key
  content      = var.s3_bucket_objects_content
  content_type = var.s3_bucket_objects_content_type
  etag         = var.s3_bucket_objects_etag
}
