output "secret_values" {
  value     = { for name, s in data.aws_secretsmanager_secret_version.version : name => s.secret_string }
  sensitive = true
}

output "secret_arns" {
  value = { for name, s in data.aws_secretsmanager_secret_version.version : name => s.arn }
}
