{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchLogs",
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Resource": [
              "arn:aws:logs:*:*:${log_group}:*"
            ]
        },
        {
            "Sid": "SourceCodeBucket",
            "Action": [
                "s3:PutObject",
                "s3:GetObjectVersion",
                "s3:GetObject",
                "s3:GetBucketLocation",
                "s3:GetBucketAcl"
            ],
            "Effect": "Allow",
            "Resource": [
                "${code_store_arn}/*",
                "${code_store_arn}"
            ]
        },
        %{ if code_store_kms_arn != "" }
        {
            "Sid": "SourceCodeBucketKMSKey",
            "Action": [
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Encrypt",
                "kms:DescribeKey",
                "kms:Decrypt"
            ],
            "Effect": "Allow",
            "Resource": "${code_store_kms_arn}"
        },
        %{ endif }
        {
            "Sid": "AllowCodeBuildVPCUsage",
            "Action": [
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeDhcpOptions",
                "ec2:DeleteNetworkInterface",
                "ec2:CreateNetworkInterface"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "AllowCodeBuildNetworkInterfaceUsage",
            "Action": "ec2:CreateNetworkInterfacePermission",
            "Condition": {
                "ArnEquals": {
                    "ec2:Subnet": ${jsonencode(subnet_arns)}
                },
                "StringEquals": {
                    "ec2:AuthorizedService": "codebuild.amazonaws.com"
                }
            },
            "Effect": "Allow",
            "Resource": "arn:aws:ec2:${iface_resource}:network-interface/*"
        }
    ]
}
