locals {
  resource_prefix = trimsuffix(var.resource_prefix, "-")
  resource_suffix = var.qualify_bucket_name == true ? "-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}" : ""
  resource_name   = "${local.resource_prefix}-${trim(var.resource_base_name, "-")}${local.resource_suffix}"
}
