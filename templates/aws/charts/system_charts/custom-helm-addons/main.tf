module "eks_blueprints_addons" {
  source            = "aws-ia/eks-blueprints-addons/aws"
  version           = "~> 1.0"
  count             = var.enabled_custom_helm ? 1 : 0
  cluster_name      = var.cluster_name
  cluster_endpoint  = var.cluster_endpoint
  oidc_provider_arn = var.cluster_oidc_provider_arn
  cluster_version   = var.cluster_version
  enable_velero     = true
  velero = {
    s3_backup_location = "${module.velero_backup_s3_bucket.s3_bucket_arn}/${var.cluster_name}/backups"
    # values = [
    #   # https://github.com/vmware-tanzu/helm-charts/issues/550#issuecomment-1959933230
    #   <<-EOT
    #   image:
    #     repository: dockerhub-remote.dock.merck.com/velero/velero
    #     tag: v1.14.1
    #   kubectl:
    #     image:
    #       repository: dockerhub-remote.dock.merck.com/bitnami/kubectl
    #       tag: 1.31.2-debian-12-r0
    # EOT
    # ]
    values = [
      file("${path.module}/values/values.yaml")
    ]
  }
}



module "velero_backup_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"
  count   = var.enabled_custom_helm ? 1 : 0

  bucket_prefix = "velero-"

  # Allow deletion of non-empty bucket
  # NOTE: This is enabled for example usage only, you should not enable this for production workloads
  force_destroy = true

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  acl = "private"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  versioning = {
    status     = true
    mfa_delete = false
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}
