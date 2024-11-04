{
    "Version": "2012-10-17",
    "Id": "GitHubWebhookHandlerPermissions",
    "Statement": [
        {
            "Sid": "AllowReadGitHubToken",
            "Action": [
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetSecretValue"
            ],
            "Resource": "${github_token_arn}",
            "Effect": "Allow"
        },
        %{ if kms_key_arn != "" }
        {
            "Sid": "AllowDecryptToken",
            "Effect": "Allow",
            "Action": [
              "kms:Decrypt",
              "kms:DescribeKey"
            ],
            "Resource": "${kms_key_arn}"
        },
        %{ endif }
        {
            "Sid": "AllowEventBusUsage",
            "Action": "events:PutEvents",
            "Resource": "${event_bus_arn}",
            "Effect": "Allow"
        }
    ]
}
