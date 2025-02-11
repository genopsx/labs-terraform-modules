locals {
  values_yaml_path = "${path.module}/yamls/values.yaml"
  base_values = templatefile(local.values_yaml_path, {
    release_name = var.release_name
    # cert_arn     = var.certificate_arn
    # domain       = var.domain_name
  })
}
