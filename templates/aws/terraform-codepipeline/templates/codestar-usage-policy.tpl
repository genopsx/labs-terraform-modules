{
    "Version": "2012-10-17",
    "Id": "CodeStarConnectionsPermissions",
    "Statement": [
        {
            "Sid": "AllowTriggerFromGitHub",
            "Effect": "Allow",
            "Action": "codestar-connections:UseConnection",
            "Resource": "${codestar_connection_arn}"
        }
    ]
}
