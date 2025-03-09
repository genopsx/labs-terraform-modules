variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
  default     = "image-factory"
}

variable "resource_base_name" {
  type        = string
  description = "The name that appears after the suffix"
  default     = "source-code"
}

variable "qualify_bucket_name" {
  type        = bool
  description = "Append the region and the account id"
  default     = true
}

variable "use_custom_kms_key" {
  type        = bool
  description = "Create a KMS key for the bucket's object(s) encryption"
  default     = true
}

variable "force_destroy_buckets" {
  type        = bool
  description = "Test mode: force destroy buckets"
  default     = false
}

variable "enable_versioning" {
  type        = bool
  description = "Enable object versioning"
  default     = true
}

variable "acl" {
  type        = string
  description = "The canned ACL profile"
  default     = "private"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "external_full_access_objects_arns" {
  type        = list(string)
  description = "List of ARNs that have full access to the bucekt's objects"
  default     = []
}

variable "object_ownership" {
  type        = string
  description = "The onwnership policy of the object created in the bucket"
  default     = "ObjectWriter"
  validation {
    condition     = can(regex("^(BucketOwnerPreferred|ObjectWriter|BucketOwnerEnforced)$", var.object_ownership))
    error_message = "The allowed values are BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  }
}
