locals {
  resource_prefix       = trimsuffix(var.resource_prefix, "-")
  state_resource_prefix = length(var.state_resource_prefix) > 0 ? var.state_resource_prefix : trimsuffix("${local.resource_prefix}-states", "-")
}
