data "aws_secretsmanager_secret" "grafana_auths" {
  arn = var.grafana_auths_secret_mgr_arn
}

data "aws_secretsmanager_secret_version" "grafana_auths_version" {
  secret_id = data.aws_secretsmanager_secret.grafana_auths.id
}
