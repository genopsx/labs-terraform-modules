variable "name" {
  description = "The name of the kubeshark"
  type        = string
}

variable "namespace" {
  description = "The namespace to deploy the kubeshark"
  type        = string
  default     = "kubeshark"
}

variable "kubeshark_helm_chart_version" {
  description = "The version of the kubeshark helm chart"
  type        = string
  default     = "52.3.38"
}

variable "domain_name" {
  description = "The domain name of the kubeshark"
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "region" {
  description = "The region to deploy the kubeshark"
  type        = string
}

variable "scheme" {
  description = "The scheme of the kubeshark"
  type        = string
  default     = "internet-facing"
}

variable "acm_certificate_arn" {
  description = "The acm certificate arn of the kubeshark"
  type        = string
}
