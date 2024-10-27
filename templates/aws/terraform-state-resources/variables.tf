variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
  default     = ""
}

variable "force_destroy_buckets" {
  type        = bool
  description = "Test mode: force destroy buckets"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
