#------------------------------------------------------------------------------
# S3 BUCKET CONFIGURATION
#------------------------------------------------------------------------------
module "s3_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "4.6.0"
  bucket                   = var.s3_bucket_name
  object_ownership         = var.object_ownership
  control_object_ownership = var.control_object_ownership
  force_destroy            = var.force_destroy
  create_bucket            = var.create_bucket
  acl                      = var.acl
  block_public_policy      = var.block_public_policy
  block_public_acls        = var.block_public_acls
  ignore_public_acls       = var.ignore_public_acls
  restrict_public_buckets  = var.restrict_public_buckets
  tags                     = var.tags
  website                  = var.website

}
