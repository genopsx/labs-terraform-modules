# eks

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.70 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.70 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_r53"></a> [acm\_r53](#module\_acm\_r53) | ./acm_r53 | n/a |
| <a name="module_ebs_kms_key"></a> [ebs\_kms\_key](#module\_ebs\_kms\_key) | ./nodegroup/kms | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./cluster | n/a |
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | ./addons | n/a |
| <a name="module_fargate"></a> [fargate](#module\_fargate) | ./fargates | n/a |
| <a name="module_nodes"></a> [nodes](#module\_nodes) | ./nodegroup | n/a |
| <a name="module_security_alb_ingress"></a> [security\_alb\_ingress](#module\_security\_alb\_ingress) | ./extra_sg | n/a |
| <a name="module_security_node"></a> [security\_node](#module\_security\_node) | ./extra_sg | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role-with-oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_record.ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.cluster_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.parent_hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_average_cpu"></a> [autoscaling\_average\_cpu](#input\_autoscaling\_average\_cpu) | Average CPU threshold to autoscale EKS EC2 instances. | `number` | `0` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster. | `string` | `"value"` | no |
| <a name="input_create_fargate_profile"></a> [create\_fargate\_profile](#input\_create\_fargate\_profile) | Whether to create a Fargate Profile. | `bool` | `false` | no |
| <a name="input_create_managed_node_groups"></a> [create\_managed\_node\_groups](#input\_create\_managed\_node\_groups) | Whether to create a managed node group. | `bool` | `false` | no |
| <a name="input_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#input\_eks\_managed\_node\_groups) | values for the EKS managed node groups. | <pre>map(object({<br>    ami_type       = string<br>    min_size       = number<br>    max_size       = number<br>    desired_size   = number<br>    instance_types = list(string)<br>    capacity_type  = string<br>    # use_custom_launch_template = bool<br>    # disk_size                  = number<br>    network_interfaces = list(object({<br>      delete_on_termination       = bool<br>      associate_public_ip_address = bool<br>    }))<br>  }))</pre> | <pre>{<br>  "name": {<br>    "ami_type": "value",<br>    "capacity_type": "value",<br>    "desired_size": 0,<br>    "instance_types": [<br>      "value"<br>    ],<br>    "max_size": 0,<br>    "min_size": 0,<br>    "network_interfaces": [<br>      {<br>        "associate_public_ip_address": false,<br>        "delete_on_termination": false<br>      }<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_enable_creation_role_with_oidc"></a> [enable\_creation\_role\_with\_oidc](#input\_enable\_creation\_role\_with\_oidc) | Enable creation of IAM roles with OIDC. | `bool` | `false` | no |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Map of Fargate profiles to create. | <pre>map(object({<br>    name          = string<br>    namespace     = string<br>    iam_role_name = string<br>    selectors = list(object({<br>      namespace = string<br>      labels    = map(string)<br>    }))<br>    additional_policies = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_iam_node_group_role"></a> [iam\_node\_group\_role](#input\_iam\_node\_group\_role) | The name of the IAM role to attach to the EKS managed node group. | `string` | `"value"` | no |
| <a name="input_iam_role_nodes_additional_policies"></a> [iam\_role\_nodes\_additional\_policies](#input\_iam\_role\_nodes\_additional\_policies) | List of additional IAM policies to attach to EKS managed node groups. | `map(string)` | `{}` | no |
| <a name="input_kubernets_version"></a> [kubernets\_version](#input\_kubernets\_version) | The Kubernetes version for the EKS cluster. | `string` | `""` | no |
| <a name="input_node_add_policy_name"></a> [node\_add\_policy\_name](#input\_node\_add\_policy\_name) | Name of the policy to attach to the EKS managed node group. | `string` | `"value"` | no |
| <a name="input_node_security_group_tags"></a> [node\_security\_group\_tags](#input\_node\_security\_group\_tags) | The tags to apply to the node security group. | `map(string)` | `{}` | no |
| <a name="input_nodegroup_subnet_ids"></a> [nodegroup\_subnet\_ids](#input\_nodegroup\_subnet\_ids) | List of subnet IDs for the EKS Node Group. | `list(string)` | `[]` | no |
| <a name="input_oic_role_configurations"></a> [oic\_role\_configurations](#input\_oic\_role\_configurations) | values for the OIDC role configurations. | <pre>map(object({<br>    role_name           = string<br>    assume_role_actions = list(string)<br>    namespace           = string<br>    service_account     = string<br>    policy_file         = string<br>  }))</pre> | <pre>{<br>  "name": {<br>    "assume_role_actions": [<br>      "value"<br>    ],<br>    "namespace": "value",<br>    "policy_file": "value",<br>    "role_name": "value",<br>    "service_account": "value"<br>  }<br>}</pre> | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of subnet IDs for the EKS Node Group. | `list(string)` | `[]` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of subnet IDs for the EKS Node Group. | `list(string)` | `[]` | no |
| <a name="input_r53_hosted_zone_name"></a> [r53\_hosted\_zone\_name](#input\_r53\_hosted\_zone\_name) | Route53 hosted zone name | `string` | `""` | no |
| <a name="input_r53_subzone_name"></a> [r53\_subzone\_name](#input\_r53\_subzone\_name) | Route53 subzone name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to the resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `"value"` | no |
| <a name="input_worker_nodes_kms_key_aliases"></a> [worker\_nodes\_kms\_key\_aliases](#input\_worker\_nodes\_kms\_key\_aliases) | List of aliases for the KMS key | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | n/a |
| <a name="output_ebs_kms_key_arn"></a> [ebs\_kms\_key\_arn](#output\_ebs\_kms\_key\_arn) | The ARN of the key |
| <a name="output_eks_certificate"></a> [eks\_certificate](#output\_eks\_certificate) | Certificate of EKS K8S cluster (base64) |
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | ARN of EKS K8S cluster |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | ID of EKS K8S cluster |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | Name of EKS K8S cluster |
| <a name="output_eks_endpoint"></a> [eks\_endpoint](#output\_eks\_endpoint) | Endpoint of EKS K8S cluster |
| <a name="output_eks_iam_role_arn"></a> [eks\_iam\_role\_arn](#output\_eks\_iam\_role\_arn) | n/a |
| <a name="output_eks_oidc_issuer_url"></a> [eks\_oidc\_issuer\_url](#output\_eks\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#output\_eks\_oidc\_provider\_arn) | The ARN of the OpenID Connect identity provider |
| <a name="output_eks_region"></a> [eks\_region](#output\_eks\_region) | Region where the cluster deployed |
| <a name="output_eks_token"></a> [eks\_token](#output\_eks\_token) | Authorization token for EKS K8S cluster |
| <a name="output_r53_zone_id"></a> [r53\_zone\_id](#output\_r53\_zone\_id) | Cluster route53 zone id |
| <a name="output_r53_zone_name"></a> [r53\_zone\_name](#output\_r53\_zone\_name) | Cluster route53 zone name |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID, where the cluster was deployed |
<!-- END_TF_DOCS -->
