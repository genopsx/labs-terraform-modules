
variable "project_prefix" {
  type        = string
  description = "AWS account prefix to be used for the given project."
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Environment of deployment. dev/test/uat/prod"
}

variable "target_vpc_id" {
  type        = string
  description = "ID of target VPC"
}

variable "routable_subnets" {
  type        = list(any)
  description = "List of subnet IDs that the EKS cluster will be deployed in"
}

variable "cluster_security_groups_names" {
  type        = list(string)
  description = "Security groups that will attached to the cluster"
}

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

