{
    "Version": "2012-10-17",
    "Statement": [
        %{ if external_principal_arns != "" }
        {
            "Sid": "AllowUseKey",
            "Effect": "Allow",
            "Principal": {
                "AWS": ${external_principal_arns}
            },
            "Action": [
              "kms:DescribeKey",
              "kms:GenerateDataKey*",
              "kms:Encrypt",
              "kms:ReEncrypt*",
              "kms:Decrypt"
            ],
            "Resource": "*"
        },
        %{ endif }
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${account_id}:root"
                ]
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
