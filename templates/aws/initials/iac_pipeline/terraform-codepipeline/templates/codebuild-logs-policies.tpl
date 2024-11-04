{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCodeBuildLogs",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:${log_group}:*"
    }
  ]
}

