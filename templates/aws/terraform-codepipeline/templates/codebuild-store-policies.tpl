{
    "Version": "2012-10-17",
    "Id": "StoragePolicies",
    "Statement": [
        {
            "Sid": "AllowListBuckets",
            "Effect": "Allow",
            "Action": [
              "s3:GetBucketVersioning",
              "s3:GetBucketAcl",
              "s3:GetBucketPolicy",
              "s3:GetEncryptionConfiguration",
              "s3:GetBucketPublicAccessBlock",
              "s3:GetBucketLocation",
              "s3:PutEncryptionConfiguration",
              "s3:PutBucketPolicy",
              "s3:ListBucket",
              "s3:ListBucketVersions"
              ],
            "Resource": ${all_buckets_arns}
        },
        {
            "Sid": "AllowReadBucketCode",
            "Effect": "Allow",
            "Action": [
              "s3:GetObject",
              "s3:GetObjectAttributes",
              "s3:GetObjectVersion",
              "s3:GetObjectVersionAttributes",
              "s3:GetObjectVersionTagging"
              ],
            "Resource": "${code_store_arn}/*"
        },
        %{ if code_store_kms_arn != "" }
        {
            "Sid": "AllowDecryptBucketCode",
            "Effect": "Allow",
            "Action": [
              "kms:Decrypt",
              "kms:DescribeKey"
              ],
            "Resource": "${code_store_kms_arn}"
        },
        %{ endif }
        {
            "Sid": "AllowReadWriteBuckets",
            "Effect": "Allow",
            "Action": [
              "s3:List*",
              "s3:*Object",
              "s3:GetObjectVersion"
              ],
            "Resource": ${read_write_paths}
        },
        {
            "Sid": "AllowUseKeyInCacheAndArtefacts",
            "Effect": "Allow",
            "Action": [
              "kms:DescribeKey",
              "kms:GenerateDataKey*",
              "kms:Encrypt",
              "kms:ReEncrypt*",
              "kms:Decrypt"
              ],
            "Resource": "${codepipeline_store_kms_arn}"
       }
    ]
}
