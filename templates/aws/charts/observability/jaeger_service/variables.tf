variable "name" {
  description = "The name of the jaeger"
  type        = string
}

variable "namespace" {
  description = "The namespace to deploy the jaeger"
  type        = string
  default     = "jaeger"
}

variable "jaeger_helm_chart_version" {
  description = "The version of the jaeger helm chart"
  type        = string
  default     = "3.2.0"
}

# tflint-ignore: terraform_unused_declarations
variable "demo_app_enabled" {
  description = "Deploy Jaeger demo application to test the service"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "The domain name of the jaeger"
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "region" {
  description = "The region to deploy the jaeger"
  type        = string
}

variable "scheme" {
  description = "The scheme of the jaeger"
  type        = string
  default     = "internet-facing"
}

variable "acm_certificate_arn" {
  description = "The acm certificate arn of the jaeger"
  type        = string
}
