locals {
  resource_prefix = trimsuffix(var.resource_prefix, "-")
  repo_name       = replace(var.git_repo, "/", "-")
}
