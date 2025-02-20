variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}


variable "object_ownership" {
  type        = string
  description = "The object ownership. Can be BucketOwnerFullControl or BucketOwnerRead"
}

variable "control_object_ownership" {
  type        = bool
  description = "A boolean that indicates the bucket should control object ownership"
}

variable "force_destroy" {
  type        = bool
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
}

variable "create_bucket" {
  type        = bool
  description = "A boolean that indicates the bucket should be created (defaults to true)"
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the bucket"
}

variable "block_public_policy" {
  type        = bool
  description = "A boolean that indicates the bucket should block public policy"
}

variable "block_public_acls" {
  type        = bool
  description = "A boolean that indicates the bucket should block public ACLs"
}

variable "ignore_public_acls" {
  type        = bool
  description = "A boolean that indicates the bucket should ignore public ACLs"
}

variable "restrict_public_buckets" {
  type        = bool
  description = "A boolean that indicates the bucket should restrict public buckets"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the bucket"
}

variable "website" {
  type = object({
    index_document = string
  })
  description = "A mapping of website configuration"
}

