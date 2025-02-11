# Common
variable "cluster_oidc_provider_arn" {
  description = "The OIDC provider ARN for the EKS cluster"
  type        = string
  default     = "arn:aws:iam::account-id:oidc-provider/oidc.eks.region.amazonaws.com/id"
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version to use for the EKS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to be attached to resources"
  type        = map(string)
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to host the cluster in"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "The domain filter to install external-dns"
}

# tflint-ignore: terraform_unused_declarations
variable "acm_certificate_arn" {
  type = string
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS cluster endpoint"
}

# Cluster autoscaler
variable "cluster_autoscaler_enabled" {
  type    = bool
  default = false
}
variable "cluster_autoscaler_namespace" {
  type    = string
  default = "kube-system"
}

# Karpenter
variable "karpenter_enabled" {
  type        = bool
  default     = false
  description = "Whether to install karpenter"
}
variable "karpenter_namespace" {
  type    = string
  default = "kube-system"
}

# # Kyverno
# variable "kyverno_enabled" {
#   type        = bool
#   description = "Whether to install kyverno"
#   default     = false
# }
# variable "kyverno_chart_name" {
#   type        = string
#   description = "Name of chart"
# }

# variable "kyverno_chart_version" {
#   type        = string
#   description = "Version of kyverno chart"
# }

# variable "kyverno_namespace" {
#   type        = string
#   description = "Namespace to install the chart into"
# }

# variable "kyverno_release_name" {
#   type        = string
#   description = "Name of release for kyverno"
# }

# # Kyverno policies
# variable "kyverno_policies_release_name" {
#   type        = string
#   description = "Name of release for policy"
# }

# variable "kyverno_policies_chart_name" {
#   type        = string
#   description = "Name of chart for policy"
# }

# variable "kyverno_policies_chart_version" {
#   type        = string
#   description = "Version of the chart for policy"
# }

# # Yunikorn
# variable "yunikorn_enabled" {
#   type    = bool
#   default = false
# }
# variable "yunikorn_release_name" {
#   type        = string
#   description = "Name of release for yunikorn"
# }
# variable "yunikorn_chart_name" {
#   type        = string
#   description = "Name of chart for yunikorn"
# }
# variable "yunikorn_chart_version" {
#   type        = string
#   description = "Version of the chart for yunikorn"
# }

# NVIDIA 
variable "nvidia_enabled" {
  type    = bool
  default = false
}
variable "nvdp_release_name" {
  type        = string
  description = "Name of release for nvidia-device-plugin"
}
variable "nvdp_chart_name" {
  type        = string
  description = "Name of chart for nvidia-device-plugin"
}

variable "nvdp_chart_version" {
  type        = string
  description = "Version of the chart for nvidia-device-plugin"
}
# AWS LB Controller
variable "alb_controller_enabled" {
  type    = bool
  default = false
}
variable "alb_controller_namespace" {
  type    = string
  default = "kube-system"
}

# Kong
variable "kong_enabled" {
  description = "Whether to install kong"
  type        = bool
  default     = false
}
variable "kong_namespace" {
  description = "The namespace to install kong"
  type        = string
  default     = "kong"
}

## External DNS
variable "eks_external_dns_enabled" {
  description = "Whether to install external-dns for eks"
  type        = bool
  default     = false
}
variable "external_dns_namespace" {
  description = "The namespace to install external-dns"
  type        = string
  default     = "external-dns"
}

# Cert Manager
variable "cert_manager_enabled" {
  description = "Whether to install cert-manager"
  type        = bool
  default     = false
}
variable "cert_manager_namespace" {
  description = "The namespace to install cert-manager"
  type        = string
  default     = "cert-manager"
}

# External Secrets
variable "external_secrets_enabled" {
  type    = bool
  default = false
}
variable "external_secrets_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}
variable "external_secrets_regex" {
  type        = string
  description = "AWS SM Secrets regex for ARN"
  default     = "*"
}

# EBS CSI Driver
variable "ebs_csi_enabled" {
  type    = bool
  default = false
}
variable "ebs_csi_driver_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

# Metrics Server
variable "metrics_server_enabled" {
  type    = bool
  default = false
}
variable "metrics_server_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

# AWS node termination handler
variable "aws_node_termination_handler_enabled" {
  type    = bool
  default = false
}
variable "aws_node_termination_handler_namespace" {
  type    = string
  default = "kube-system"
}

# Keda
variable "keda_enabled" {
  default = false
  type    = bool
}
variable "keda_poc_enabled" {
  default = false
  type    = bool
}
variable "keda_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "keda"
}

# Helm Addons
variable "enabled_custom_helm" {
  description = "Flag to enable or disable the creation of custom Helm addons and associated resources"
  type        = bool
  default     = false # Set to true to create the resources
}


# Rancher
variable "rancher_enabled" {
  type    = bool
  default = false
}
variable "rancher_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "rancher"
}
variable "rancher_chart_name" {
  type        = string
  description = "Helm chart to release"
  default     = "rancher"
}
variable "rancher_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "cattle-system"
}
variable "rancher_chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "1.15.0"
}

# Fairwinds
# vpa (Vertical Pod Autoscaler)
variable "vpa_enabled" {
  type    = bool
  default = false
}

variable "vpa_release_name" {
  type        = string
  description = "Name of the helm release"
}

variable "vpa_chart_version" {
  type        = string
  description = "Version of the chart"
}

variable "vpa_namespace" {
  type        = string
  description = "Namespace to install the chart into"
}


# Goldilocks
variable "goldilocks_enabled" {
  type    = bool
  default = false
}
variable "goldilocks_release_name" {
  type        = string
  description = "Name of the helm release"
}

variable "goldilocks_chart_version" {
  type        = string
  description = "Version of the chart"
}

variable "goldilocks_namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

# Polaris
variable "polaris_enabled" {
  type    = bool
  default = false
}
variable "polaris_release_name" {
  type        = string
  description = "Name of the helm release"
}

variable "polaris_chart_version" {
  type        = string
  description = "Version of the chart"
}

variable "polaris_namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

# Gemini
variable "gemini_enabled" {
  type    = bool
  default = false
}

variable "gemini_release_name" {
  type        = string
  description = "Name of the helm release"
}

variable "gemini_chart_version" {
  type        = string
  description = "Version of the chart"
}

variable "gemini_namespace" {
  type        = string
  description = "Namespace to install the chart into"
}

# Helm Release Pruner 
variable "helm_release_pruner_enabled" {
  type    = bool
  default = false
}

variable "helm_release_pruner_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "helm_release_pruner_chart_version" {
  type        = string
  description = "Version of the chart"
  default     = "0.1.0"
}

variable "helm_release_pruner_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "helm-release-pruner"
}

# RBAC Manager
variable "rbac_manager_enabled" {
  type    = bool
  default = false
}

variable "rbac_manager_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "rbac_manager_chart_version" {
  type        = string
  description = "Version of the chart"
  default     = "0.1.0"
}

variable "rbac_manager_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "rbac-manager"
}

# Insights Admission
variable "insights_admission_enabled" {
  type    = bool
  default = false
}

variable "insights_admission_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "insights_admission_chart_version" {
  type        = string
  description = "Version of the chart"
  default     = "0.1.0"
}

variable "insights_admission_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "insights-admission"
}

# Ecr Cleanup 
variable "ecr_cleanup_enabled" {
  type    = bool
  default = false
}

variable "ecr_cleanup_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "ecr_cleanup_chart_version" {
  type        = string
  description = "Version of the chart"
  default     = "0.1.0"
}


variable "ecr-cleanup-repos" {
  description = "comma-separated list of repository names to watch."
  type        = string
}

variable "ecr-cleanup-region" {
  description = "region to use when talking to AWS. (default \"us-east-1\")"
  type        = string
}

variable "ecr-cleanup-namespaces" {
  description = "do not remove images used by pods in this comma-separated list of namespaces. (default \"default\")"
  type        = string
}

variable "ecr_cleanup_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "ecr-cleanup"
}

# AWS Iam Authenticator
variable "aws_iam_authenticator_enabled" {
  type    = bool
  default = false
}

variable "aws_iam_authenticator_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "aws_iam_authenticator_chart_version" {
  type        = string
  description = "Version of the chart"
  default     = "0.1.0"
}

variable "aws_iam_authenticator_release_name" {
  type        = string
  description = "Name of the helm release"
  default     = "aws-iam-authenticator"
}
