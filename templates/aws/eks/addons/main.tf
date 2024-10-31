resource "aws_eks_addon" "this" {
  count        = var.enable_eks_addons ? length(local.addons) : 0
  cluster_name = var.cluster_name
  addon_name   = local.addons[count.index].addon_name

  dynamic "addon_version" {
    for_each = local.addons[count.index].addon_version != "" ? [local.addons[count.index].addon_version] : []
    content {
      addon_version = addon_version.value
    }
  }

  dynamic "service_account_role_arn" {
    for_each = local.addons[count.index].service_account_role_arn != "" ? [local.addons[count.index].service_account_role_arn] : []
    content {
      service_account_role_arn = service_account_role_arn.value
    }
  }

  resolve_conflicts_on_create = "OVERWRITE"
  tags                        = var.tags
}
