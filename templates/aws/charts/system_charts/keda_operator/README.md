# Terraform Module for Deploying KEDA on EKS with SQS Scaler

This Terraform module automates the deployment of a Kubernetes-based Event-Driven Autoscaler (KEDA) on Amazon EKS. It sets up an EKS cluster, configures OIDC, deploys the KEDA operator, and establishes a trust policy for the KEDA operator. Additionally, it deploys an SQS scaler `ScaledObject` and a Python application designed to load messages into the SNS queue, which also gets scaled by KEDA based on queue length.

## Prerequisites

- Terraform 0.14+
- AWS CLI configured
- Kubernetes CLI (kubectl) configured
- Helm 3.0+

## Features

- **EKS Cluster Deployment:** Sets up a fully functional EKS cluster.
- **OIDC Setup:** Configures OIDC for the EKS cluster, facilitating secure service operations.
- **KEDA Operator Deployment:** Utilizes Helm to deploy the KEDA operator within the specified namespace.
- **Trust Policy Configuration:** Establishes a trust policy for the KEDA operator to perform necessary operations in the EKS cluster.
- **SQS Scaler Deployment:** Deploys an SQS scaler `ScaledObject` to automatically scale workloads based on the queue length.
- **Python Application Deployment:** Deploys a Python application to interact with the SNS queue, serving as the workload to be scaled.

## Usage

To use this module in your Terraform environment, follow the steps below:

1. **Module Declaration:**

```hcl
module "keda_on_eks" {
  source = "./module"

  // Variables
  namespace                    = "keda"
  chart_name                   = "keda"
  repository                   = "https://kedacore.github.io/charts"
  chart_version                = "2.13.0"
  keda_service_account_name    = "keda-operator"
  max_replica_count            = 10
  min_replica_count            = 1
  deployment_name              = "keda-py-test"
  cidr_block                   = "10.0.0.0/16"
  cluster_name                 = "keda-core"
  node_group_name              = "keda-ng"
  disk_size                    = 100
  instance_types               = ["t3.medium"]
  desired_size                 = 2
  max_size                     = 2
  min_size                     = 1
  enable_sqs_scaler            = true
  sqs_name                     = "<your-sqs-name>"
  sqs_queue_length             = 10
  sqs_policy_actions           = ["sqs:SendMessage"]
  py_service_account_name      = "sqs-test"
}
```

2. **Initialization:**

Run `terraform init` to initialize the Terraform configuration and download required providers.

3. **Apply Configuration:**

Execute `terraform apply` to create the resources on AWS as defined in the module.

## Customization

- **Scaling Parameters:** Adjust `deployment_name` , `max_replica_count` and `min_replica_count` to control the scaling behavior.
- **Cluster Configuration:** Modify `cidr_block`, `cluster_name`, `node_group_name`, etc., to customize the EKS cluster.
- **SQS Scaler:** Set `enable_sqs_scaler` to `true` and specify `sqs_name` and `sqs_queue_length` to deploy an SQS scaler.
- **Python Application Deployment:** The module deploys a Python application for demonstration purposes. Customize the application deployment as needed in `py.tf`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keda_poc"></a> [keda\_poc](#module\_keda\_poc) | ./keda_poc | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.keda](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | n/a | `string` | `"keda"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The Keda helm chart version | `string` | `"2.14.3"` | no |
| <a name="input_cluster_oidc_provider_arn"></a> [cluster\_oidc\_provider\_arn](#input\_cluster\_oidc\_provider\_arn) | The Cluster oidc provider | `string` | n/a | yes |
| <a name="input_keda_poc_enabled"></a> [keda\_poc\_enabled](#input\_keda\_poc\_enabled) | To enable the keda poc or just install the keda operator | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"keda"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Keda Chart Repository | `string` | `"https://kedacore.github.io/charts"` | no |
| <a name="input_sqs_policy_actions"></a> [sqs\_policy\_actions](#input\_sqs\_policy\_actions) | Permissions to attach to the SQS Policy | `list(string)` | <pre>[<br>  "sqs:SendMessage"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
