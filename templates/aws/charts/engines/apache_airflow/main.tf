resource "helm_release" "airflow" {
  name             = var.name
  chart            = "airflow"
  repository       = "https://airflow.apache.org"
  create_namespace = var.namespace == "default" ? false : true
  version          = var.chart_version
  namespace        = var.namespace
  values           = [local.base_values]

  ## Higher timeout that CaS would be able to bring nodes
  timeout = 600
}

# MERCK

# # Deploy service IAM roles for EKS cluster and Fargate
# module "iam-eks-srv" {
#   source = "../../../modules/iam-eks-srv"

#   project_prefix = var.project_prefix
#   region         = var.region
# }


# # Deploy Fargate profile for infra kubernetes components
# module "eks-fargate-infra" {
#   source = "../../../modules/eks-fargate-infra"

#   cluster_name             = module.eks.cluster_name
#   profile_name             = "${var.project_prefix}-airflowfdna-eks-fargate-infra"
#   fargate_role_arn         = module.iam-eks-srv.fargate_role_arn
#   subnet_ids               = var.non_routable_subnets
#   coredns_replicas         = var.coredns_replicas
#   vpc_cni_addon_version    = var.vpc_cni_addon_version
#   coredns_addon_version    = var.coredns_addon_version
#   kube_proxy_addon_version = var.kube_proxy_addon_version
# }

# Deploy S3 bucket for Airflow logs
module "s3" {
  source = "./modules/s3"

  bucket_name = "${var.project_prefix}-airflowfdna-task-logs-${data.aws_region.current.name}-${var.environment}"
}

# Deploy subnet group and security group for Elasticache Redis
module "redis-support" {
  source                  = "./modules/redis-support"
  redis_sg_name           = "${var.project_prefix}-airflowfdna-redis-sg"
  redis_subnet_group_name = "${var.project_prefix}-airflowfdna-redis-subnetgroup"
  redis_vpc_id            = var.vpc_id
  redis_subnets           = var.database_subnets
}

# Deploy subnet group and parameter group for RDS
module "rds-support" {
  source = "./modules/rds-support"

  rds_subnet_group_name      = "${var.project_prefix}-airflowfdna-metadata-subnetgroup"
  rds_subnets                = var.database_subnets
  rds_parameter_group_name   = "${var.project_prefix}-eks-pg${var.rds_parameter_group_family}"
  rds_parameter_group_family = var.rds_parameter_group_family
  rds_parameters             = var.rds_parameters
}


# Deploy EFS drive with mount targets and access point for prometheus
module "efs" {
  source = "./modules/efs"

  efs_name                  = "${var.project_prefix}-airflowfdna-efs-${var.environment}"
  efs_throughput_mode       = var.efs_throughput_mode
  efs_mount_targets_subnets = var.private_subnets
  efs_mount_targets_sg      = var.cluster_security_groups_ids
  # efs_ap_name               = "${var.project_prefix}-airflowfdna-efs-prometheus-ap"
}

############################################################################################################

# variable "common_tags" {
#   description = "Common tags to be assigned across infrastructure pieces"
#   type        = map(string)
# }

variable "project_prefix" {
  type        = string
  description = "AWS account prefix to be used for the given project."
}

# variable "region" {
#   type        = string
#   description = "AWS region"
# }

variable "environment" {
  type        = string
  description = "Environment of deployment. dev/test/uat/prod"
}

# variable "target_vpc_id" {
#   type        = string
#   description = "ID of target VPC"
# }

# variable "vpc_cni_addon_version" {
#   type        = string
#   description = "vpc cni addon eks version"
# }

# variable "coredns_addon_version" {
#   type        = string
#   description = "coredns addon eks version"
# }

# variable "kube_proxy_addon_version" {
#   type        = string
#   description = "kube proxy addon eks version"
# }

# variable "routable_subnets" {
#   type        = list(any)
#   description = "List of subnet IDs that the EKS cluster will be deployed in"
# }

variable "cluster_security_groups_ids" {
  type        = list(string)
  description = "Security groups that will attached to the cluster"
}

# variable "enabled_cluster_log_types" {
#   type        = list(string)
#   description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`]"
# }

# variable "kubernetes_version" {
#   type        = string
#   description = "Version of kubernetes"
# }

# variable "non_routable_subnets" {
#   type        = list(any)
#   description = "List of subnet IDs that the k8s pods will be deployed in. Merck non routables"
# }

# variable "route53_hosted_zone_name" {
#   type        = string
#   description = "Hosted zone name for this cluster e.g. usdev.airflow.merck.com"
# }

variable "efs_throughput_mode" {
  type        = string
  description = "Throughput mode of EFS drive. bursting or elastic"
}

variable "rds_parameter_group_family" {
  type        = string
  description = "Parameter group family"
}

variable "rds_parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
}

# variable "coredns_replicas" {
#   type        = number
#   description = "Number of coredns pod replicas"
# }
