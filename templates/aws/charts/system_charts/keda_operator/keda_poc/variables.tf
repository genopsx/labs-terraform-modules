variable "namespace" {
  default = "keda"
  type    = string
}

# tflint-ignore: terraform_unused_declarations
variable "chart_name" {
  default = "keda"
  type    = string
}

# tflint-ignore: terraform_unused_declarations
variable "repository" {
  type        = string
  default     = "https://kedacore.github.io/charts"
  description = "Keda Chart Repository"
}

# tflint-ignore: terraform_unused_declarations
variable "chart_version" {
  type        = string
  default     = "2.13"
  description = "The Keda helm chart version"
}

variable "keda_service_account_name" {
  type        = string
  default     = "keda-operator"
  description = "The Service account that allows the keda operator perform operation in the EKS cluster"
}

variable "producer_deployment_name" {
  type        = string
  default     = "keda-producer"
  description = "Name of keda  producer Deployment"
}

variable "consumer_deployment_name" {
  type        = string
  default     = "keda-consumer"
  description = "Name of keda consumer Deployment"
}

variable "app_deployment_name" {
  type        = string
  default     = "keda-app"
  description = "Name of app Deployment to be scaled"
}

variable "sqs_name" {
  type    = string
  default = "keda-queue"
}

variable "py_service_account_name" {
  type    = string
  default = "sqs-test"
}

variable "sqs_queue_length" {
  type        = string
  default     = "10"
  description = "The queue length used to scaled the workloads"
}

variable "sqs_policy_actions" {
  default     = ["sqs:SendMessage"]
  description = "Permissions to attach to the SQS Policy"
  type        = list(string)
}

variable "cluster_oidc_provider_arn" {
  description = "The Cluster oidc provider"
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "enable_keda_poc" {
  default     = false
  description = "To enable the keda poc or just install the keda operator"
  type        = bool
}

variable "cooldown_period" {
  description = "The time it takes to scale back down in seconds"
  default     = 2
  type        = number
}

variable "min_replica_count" {
  description = "The minimum replica count"
  default     = 0
  type        = number
}

variable "max_replica_count" {
  description = "The maximum replica count"
  default     = 10
  type        = number
}


variable "polling_interval" {
  description = "The interval at which keda polls the target in seconds"
  default     = 2
  type        = number
}

variable "region" {
  default = "eu-west-1"
  type    = string
}
