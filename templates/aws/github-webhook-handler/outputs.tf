output "github_secret_token" {
  description = "The secret token to be passed to GitHub's webhook"
  sensitive   = true
  value       = random_password.github_token.result
}

output "github_webhook_handler_url" {
  description = "The URL to pass to GitHub"
  value       = module.handler.lambda_function_url
}

output "eventbridge_bus_name" {
  description = "The name of the EventBridge bus where the webhook handler sends the notifications"
  value       = local.cloudwatch_event_bus.name
}
