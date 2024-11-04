variable "resource_prefix" {
  type        = string
  description = "Prefix to use to name resources"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "lambda_source_bucket_prefix" {
  description = "The basename of the bucket which hosts the Lambda function's code"
  type        = string
  default     = "eventbridge-inbound-webhook-templates-prod"
}

variable "lambda_source_file_path" {
  description = "The path (relative to an AWS bucket) with the Lambda function's code"
  type        = string
  default     = "lambda-templates/github-lambdasrc.zip"
}

variable "lambda_invocation_threshold" {
  description = "The number of calls to the GitHub Webhook Lambda function in a 5 minutes interval that triggers an alarm"
  type        = number
  default     = 50
}

variable "custom_eventbridge_bus" {
  description = "Whether to create a custom EventBridge bus or use the default one"
  type        = bool
  default     = true
}

variable "use_custom_kms_key_for_token" {
  description = "Create a custom KMS key to store the token in the SecretManager"
  type        = bool
  default     = false
}
