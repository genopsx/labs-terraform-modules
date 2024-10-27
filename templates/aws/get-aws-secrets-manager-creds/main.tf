data "aws_secretsmanager_secret" "secret" {
  for_each = var.secrets
  name     = each.value.name
}

data "aws_secretsmanager_secret_version" "version" {
  for_each      = data.aws_secretsmanager_secret.secret
  secret_id     = each.value.id
  version_stage = var.secrets[each.key]["version"]
}
