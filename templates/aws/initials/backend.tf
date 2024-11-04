terraform {
  backend "s3" {
    bucket         = "deployment-states-terragrunt-sbx-eu-west-1-955769636964"
    dynamodb_table = "deployment-locks-terragrunt-sbx-eu-west-1-955769636964"
    kms_key_id     = "arn:aws:kms:eu-west-1:955769636964:key/53e2108b-0481-4fcb-8b7e-9f1ed1d25b8f"
    region         = "eu-west-1"
    key            = "state"
  }
}

