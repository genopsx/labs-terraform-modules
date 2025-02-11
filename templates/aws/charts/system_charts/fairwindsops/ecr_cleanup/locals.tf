locals {
  values_yaml_path = "${path.module}/yamls/values.yaml"
  base_values = templatefile(local.values_yaml_path, {
    ecr-cleanup-role-arn = module.ecr_cleanup_irsa_role.iam_role_arn
    # comma-separated list of repository names to watch.
    repos = var.ecr-cleanup-repos
    # region to use when talking to AWS. (default "us-east-1")
    region = var.ecr-cleanup-region
    # do not remove images used by pods in this comma-separated list of namespaces. (default "default")
    namespaces = var.ecr-cleanup-namespaces
  })
}



