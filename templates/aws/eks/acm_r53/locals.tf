locals {
  fqdn = "${coalesce(var.r53_subzone_name, var.cluster_name)}.${var.r53_hosted_zone_name}"
  # tflint-ignore: terraform_unused_declarations
  private = "private"
  # tflint-ignore: terraform_unused_declarations
  public = "public"
}
