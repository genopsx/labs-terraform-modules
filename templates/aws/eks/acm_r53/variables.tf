variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags to apply to the resources"
}

variable "r53_subzone_name" {
  type        = string
  default     = ""
  description = "The subzone name"
}

variable "r53_hosted_zone_name" {
  type        = string
  default     = ""
  description = "The hosted zone name"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "The name of the cluster"
}
