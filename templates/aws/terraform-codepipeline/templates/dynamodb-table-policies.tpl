{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowReadWriteStatusDynamoDBTable",
      "Effect": "Allow",
      "Action": [
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": ${terraform_state_dynamodb_tables_arns}
    }
  ]
}

