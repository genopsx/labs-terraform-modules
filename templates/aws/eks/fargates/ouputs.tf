output "fargate_profile_arn" {
  description = "The Amazon Resource Name (ARN) of the Fargate Profile"
  value       = module.fargate_profile[*].fargate_profile_arn
}

output "fargate_profile_id" {
  description = "The ID of the Fargate Profile"
  value       = module.fargate_profile[*].fargate_profile_id
}

output "fargate_profile_name" {
  description = "The name of the Fargate Profile"
  value       = module.fargate_profile[*].fargate_profile_name
}

output "fargate_profile_pod_execution_role_arn" {
  description = "The Amazon Resource Name (ARN) of the pod execution role"
  value       = module.fargate_profile[*].fargate_profile_pod_execution_role_arn
}
