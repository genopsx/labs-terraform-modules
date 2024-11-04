terraform {
  backend "s3" {
    bucket         = "if2-pipeline-states-eu-central-1-720257828372"
    dynamodb_table = "if2-pipeline-locks-eu-central-1-720257828372"
    kms_key_id     = "alias/if2-pipeline-stateskey-eu-central-1-720257828372"
    region         = "eu-central-1"
    key            = "state"
  }
}

