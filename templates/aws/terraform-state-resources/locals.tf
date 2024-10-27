locals {
  resource_prefix       = trimsuffix(var.resource_prefix, "-")
  state_resource_prefix = "${local.resource_prefix}-states"
}
