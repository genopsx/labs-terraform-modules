{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowExternalListBucket",
            "Effect": "Allow",
            "Principal": {
                "AWS": ${principal_arns}
            },
            "Action": [
              "s3:ListBucket",
              "s3:GetBucket*"
            ],
            "Resource": "arn:aws:s3:::${bucket_name}"
        },
        {
            "Sid": "AllowExternalAllObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": ${principal_arns}
            },
            "Action": "s3:*Object*",
            "Resource": "arn:aws:s3:::${bucket_name}/*"
        }
    ]
}
