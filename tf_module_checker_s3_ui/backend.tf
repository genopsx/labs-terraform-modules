terraform {
  backend "s3" {
    bucket = "genopsx-development-pocs-states"
    key    = "tf_module_version_checker/terraform.tfstate"
    region = "eu-west-1"
  }
}
