# Required AWS provider version
terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
  # Setup S3 and DynamoDB backend. Both S3 bucket and DynamoDB are created as a prerequisite during AWS account setup. Backend key must be unique in given AWS account.
  backend "s3" {
  }
}

# Setup AWS provider with default tags as requested by Merck policy. Resources will be deployed to this region.
provider "aws" {
  region = var.region
  ignore_tags { keys = ["Contact"] }
  default_tags {
    tags = {
      Environment        = var.common_tags.Environment
      Application        = var.common_tags.Application
      Costcenter         = var.common_tags.Costcenter
      Division           = var.common_tags.Division
      DataClassification = var.common_tags.DataClassification
      Consumer           = var.common_tags.Consumer
      Service            = var.common_tags.Service
      Project            = var.common_tags.Project
    }
  }
  assume_role {
    role_arn = "arn:aws:iam::331013986936:role/airflow-eks-deployment-role"
  }
}

# AWS provider with different region that will be used for cross-region replication
provider "aws" {
  region = var.backup_region
  alias  = "replica"
  default_tags {
    tags = {
      Environment        = var.common_tags.Environment
      Application        = var.common_tags.Application
      Costcenter         = var.common_tags.Costcenter
      Division           = var.common_tags.Division
      DataClassification = var.common_tags.DataClassification
      Consumer           = var.common_tags.Consumer
      Service            = var.common_tags.Service
      Project            = var.common_tags.Project
    }
  }
  assume_role {
    role_arn = "arn:aws:iam::331013986936:role/airflow-eks-deployment-role"
  }
}

# AWS provider with static us-east-1 region. In us-east-1 region there will be AWS secretsmanager secret that will have sensitive values that are common across instances.
provider "aws" {
  region = "us-east-1"
  alias  = "secrets"
  assume_role {
    role_arn = "arn:aws:iam::331013986936:role/airflow-eks-deployment-role"
  }
}

# Generate fernet key for Airflow
resource "random_id" "fernet_key" {
  byte_length = 32
}

# Generate random password for airflow metadata DB user
resource "random_password" "airflow_pw" {
  length           = 15
  special          = false
  override_special = "=!.$-_"
  min_numeric      = 2
  min_special      = 0
  min_upper        = 3
}

# Generate random password for airflow_read metadata DB user
resource "random_password" "airflow_read_pw" {
  length           = 15
  special          = false
  override_special = "=!.$-_"
  min_numeric      = 2
  min_special      = 0
  min_upper        = 3
}


# Pull common secrets from secrets manager. Secret has to be previously manually created in us-east-1 region.
data "aws_secretsmanager_secret" "secrets" {
  name     = var.secretsmanager_common_secrets_name
  provider = aws.secrets
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
  provider  = aws.secrets
}

locals {
  credentials = jsondecode(
    data.aws_secretsmanager_secret_version.current.secret_string
  )
}

# Create fargate profile in existing EKS cluster for namespace where Airflow instance will run.
module "eks-fargate-proj" {
  source = "../../../../../modules/eks-fargate-proj"

  cluster_name      = "aparflow-airflowfdna-eks-cluster-dev"
  profile_name      = "${var.project_prefix}-airflowfdna-eks-fargate-${var.project_id}"
  fargate_role_name = "aparflow-eks-fargate-role"
  subnet_ids        = var.non_routable_subnets
  namespace         = "arf${var.project_id}"
}


# Create EFS Access point in region EFS drive where DAGs for given Airflow instance will be stored.
module "efs-proj" {
  source = "../../../../../modules/efs-proj"

  efs_name    = "aparflow-airflowfdna-efs-dev"
  efs_path    = "/${var.project_id}_dags"
  efs_ap_name = "${var.project_prefix}-airflowfdna-efs-ap-${var.project_id}"
}


# Create Postgres RDS for Airflow metadata database
module "rds" {
  source = "../../../../../modules/rds"

  identifier                = "${var.project_prefix}-airflowfdna-metadata-${var.project_id}-${var.environment}"
  allocated_storage         = var.rds_allocated_storage
  engine_version            = var.rds_engine_version
  instance_class            = var.rds_instance_class
  password                  = local.credentials.rds_postgres_master_password
  parameter_group_name      = "aparflow-eks-postgrespg14"
  db_subnet_group_name      = "aparflow-airflowfdna-metadata-subnetgroup"
  security_group_names      = var.rds_vpc_security_group_names
  port                      = var.rds_port
  final_snapshot_identifier = "${var.project_prefix}-airflowfdna-metadata-${var.project_id}-${var.environment}-final-snapshot"
  storage_type              = var.rds_storage_type
  backup_retention_period   = var.rds_backup_retention_period
  delete_protection         = var.rds_delete_protection
  replica_kms_key_name      = var.rds_replica_kms_key_name
  maintenance_window        = var.rds_maintenance_window
  backup_window             = var.rds_backup_window
  airflow_password          = random_password.airflow_pw.result
  airflow_read_password     = random_password.airflow_read_pw.result

  providers = {
    aws.main    = aws
    aws.replica = aws.replica
  }
}

# Create elasticache Redis. Is used as message broker for Celery.
module "redis" {
  source = "../../../../../modules/redis"

  auth_token           = local.credentials.redis_auth
  replication_group_id = "${var.project_prefix}-redis-${var.project_id}-${var.environment}"
  multi_az_enabled     = var.redis_multi_az_enabled
  node_type            = var.redis_node_type
  num_cache_clusters   = var.redis_num_cache_clusters
  port                 = var.redis_port
  parameter_group      = var.redis_parameter_group
  subnet_group_name    = "aparflow-airflowfdna-redis-subnetgroup"
  engine_version       = var.redis_engine_version
  security_group_name  = "aparflow-airflowfdna-redis-sg"
  maintenance_window   = var.redis_maintenance_window
  automatic_failover   = var.redis_automatic_failover
}

# Create secret in AWS secrets manager with sensitive values that are needed by Airflow instance.
module "secretsmanager" {
  source = "../../../../../modules/secretsmanager"

  project_prefix               = var.project_prefix
  project_id                   = var.project_id
  environment                  = var.environment
  backup_region                = var.backup_region
  fernet_key                   = "${random_id.fernet_key.b64_url}="
  metadata_store_postgres_host = module.rds.rds_host
  metadata_store_postgres_port = var.rds_port
  redis_host                   = module.redis.redis_host
  redis_auth_token             = local.credentials.redis_auth
  webserver_secret             = local.credentials.webserver_secret
  flower_ui_access             = local.credentials.flower_ui_access
  ldap_password                = local.credentials.ldap_password
  git_sync_github_user         = local.credentials.git_sync_github_user
  git_sync_github_pat          = local.credentials.git_sync_github_pat
  airflow_password             = random_password.airflow_pw.result
  airflow_read_password        = random_password.airflow_read_pw.result
  postgres_master_password     = local.credentials.rds_postgres_master_password
}
