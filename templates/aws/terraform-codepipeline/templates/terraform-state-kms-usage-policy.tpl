{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowKeyUsage",
            "Effect": "Allow",
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": ${terraform_state_keys_arns}
        },
        {
            "Sid": "AllowPersistentResourcesAttachment",
            "Effect": "Allow",
            "Action": [
                "kms:CreateGrant",
                "kms:ListGrants",
                "kms:RevokeGrant"
            ],
            "Resource": ${terraform_state_keys_arns},
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": "true"
                }
            }
        }
    ]
}
