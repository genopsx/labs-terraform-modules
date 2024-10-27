{
    "Version": "2012-10-17",
    "Id": "SSEAndSSLPolicy",
    "Statement": [
        {
            "Sid": "AllowListBuckets",
            "Effect": "Allow",
            "Action": [
              "s3:GetBucketVersioning",
              "s3:GetBucketAcl",
              "s3:ListBucket",
              "s3:ListBucketVersions"
              ],
            "Resource": [
              "${code_store_arn}",
              "${artefacts_store_arn}"
            ]
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
            "Sid": "AllowReadWriteArtefacts",
            "Effect": "Allow",
            "Action": [
              "s3:*Object",
              "s3:GetObjectVersion"
              ],
            "Resource": "${artefacts_store_arn}/*/sourcecode/*"
        },
        {
            "Sid": "AllowUseKeyInArtefacts",
            "Effect": "Allow",
            "Action": [
              "kms:DescribeKey",
              "kms:GenerateDataKey*",
              "kms:Encrypt",
              "kms:ReEncrypt*",
              "kms:Decrypt"
              ],
            "Resource": "${artefacts_store_kms_arn}"
        }
    ]
}
