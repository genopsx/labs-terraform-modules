{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codebuild:StartBuild",
                "codebuild:BatchGetBuilds"
            ],
            "Effect": "Allow",
            "Resource": ${codebuild_projects}
        }
    ]
}
