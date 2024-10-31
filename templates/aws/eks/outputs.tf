output "eks_cluster_name" {
  description = "Name of EKS K8S cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "ARN of EKS K8S cluster"
  value       = module.eks.cluster_arn
}


output "eks_cluster_id" {
  description = "ID of EKS K8S cluster"
  value       = module.eks.cluster_id
}

# output "eks_primary_security_group_id" {
#   value = module.eks.cluster_primary_security_group_id
# }

# output "eks_version" {
#   description = "Version of EKS K8S cluster"
#   value       = module.eks.cluster_version
# }

# output "eks_service_role_arn" {
#   description = "ARN of the EKS cluster service role"
#   value       = module.eks.cluster_service_role_arn
# }

# output "eks_service_cidr" {
#   description = "CIDR block for the EKS cluster service"
#   value       = module.eks.cluster_service_cidr
# }


output "eks_endpoint" {
  description = "Endpoint of EKS K8S cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_certificate" {
  description = "Certificate of EKS K8S cluster (base64)"
  value       = module.eks.cluster_certificate_authority_data
}

# output "eks_token" {
#   description = "Authorization token for EKS K8S cluster"
#   value       = data.aws_eks_cluster_auth.eks.token
#   sensitive   = true
# }

output "eks_iam_role_arn" {
  description = "Cluster IAM role"
  value       = module.eks.cluster_iam_role_arn
}

output "eks_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.eks.cluster_oidc_issuer_url
}

# output "eks_oidc_provider" {
#   description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
#   value       = module.eks.oidc_provider
# }

output "eks_oidc_provider_arn" {
  description = "The ARN of the OpenID Connect identity provider"
  value       = module.eks.oidc_provider_arn
}

output "vpc_id" {
  description = "VPC ID, where the cluster was deployed"
  value       = var.vpc_id
}

# output "r53_zone_name" {
#   description = "Cluster route53 zone name"
#   value       = aws_route53_zone.cluster_zone.name
# }

# output "r53_zone_id" {
#   description = "Cluster route53 zone id"
#   value       = aws_route53_zone.cluster_zone.id
# }

# output "acm_certificate_arn" {
#   value = module.acm_r53.acm_certificate_arn
# }

# Nodegroup outputs
# output "node_group_autoscaling_group_names" {
#   value = module.eks_managed_node_groups.node_group_autoscaling_group_names
# }

# output "additional_policy_arn" {
#   value = module.additional_policy.arn
# }

# output "node_iam_role_arn" {
#   value = module.eks_managed_node_groups.iam_role_arn
# }

# output "node_iam_role_name" {
#   value = module.eks_managed_node_groups.iam_role_name
# }

##################################################

output "ebs_kms_key_arn" {
  description = "The ARN of the key"
  value       = module.ebs_kms_key.ebs_kms_key_arn
}

# tflint-ignore: terraform_unused_declarations
output "eks_region" {
  description = "Region where the cluster deployed"
  value       = data.aws_region.current.name
}

##################################################

# output "cluster_certificate_authority_data" {
#   description = "Cluster certificate authority data"
#   value       = module.eks.cluster_certificate_authority_data
# }

# output "cluster_arn" {
#   description = "Cluster ARN"
#   value       = module.eks.cluster_arn
# }

# output "cluster_iam_role_arn" {
#   description = "Cluster IAM role"
#   value       = module.eks.cluster_iam_role_arn
# }

# output "cluster_endpoint" {
#   description = "Cluster endpoint"
#   value       = module.eks.cluster_endpoint
# }

output "cluster_iam_role_name" {
  description = "Cluster IAM role name"
  value       = module.eks.cluster_iam_role_name
}

# output "cluster_id" {
#   description = "Cluster ID"
#   value       = module.eks.cluster_id
# }

output "cluster_identity_providers" {
  description = "Cluster identity providers"
  value       = module.eks.cluster_identity_providers
}

output "cluster_ip_family" {
  description = "Cluster IP family"
  value       = module.eks.cluster_ip_family
}

# output "cluster_name" {
#   description = "Cluster name"
#   value       = module.eks.cluster_name
# }

# output "cluster_oidc_issuer_url" {
#   description = "Cluster OIDC issuer URL"
#   value       = module.eks.cluster_oidc_issuer_url
# }

output "cluster_platform_version" {
  description = "Cluster platform version"
  value       = module.eks.cluster_platform_version
}

output "cluster_primary_security_group_id" {
  description = "Cluster primary security group ID"
  value       = module.eks.cluster_primary_security_group_id
}

output "cluster_service_cidr" {
  description = "Cluster service CIDR"
  value       = module.eks.cluster_service_cidr
}

output "cluster_status" {
  description = "Cluster status"
  value       = module.eks.cluster_status
}

output "cluster_version" {
  description = "Cluster version"
  value       = module.eks.cluster_version
}

output "kms_key_arn" {
  description = "KMS key ARN"
  value       = module.eks.kms_key_arn
}

output "kms_key_id" {
  description = "KMS key ID"
  value       = module.eks.kms_key_id
}

output "kms_key_policy" {
  description = "KMS key policy"
  value       = module.eks.kms_key_policy
}

output "node_security_group_arn" {
  description = "Node security group ARN"
  value       = module.eks.node_security_group_arn
}

output "oidc_provider" {
  description = "OIDC provider"
  value       = module.eks.oidc_provider
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}

output "cloudwatch_log_group_arn" {
  description = "CloudWatch log group ARN"
  value       = module.eks.cloudwatch_log_group_arn
}

output "cloudwatch_log_group_name" {
  description = "CloudWatch log group name"
  value       = module.eks.cloudwatch_log_group_name
}

output "eks_token" {
  description = "Authorization token for EKS K8S cluster"
  value       = module.eks.eks_token
  sensitive   = true
}

output "acm_certificate_arn" {
  value = module.eks.acm_certificate_arn
}

output "r53_zone_name" {
  description = "Cluster Route 53 zone name"
  value       = module.eks.r53_zone_name
}

output "r53_zone_id" {
  description = "Cluster Route 53 zone ID"
  value       = module.eks.r53_zone_id
}
