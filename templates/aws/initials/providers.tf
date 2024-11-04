terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.14.0"
    }
  }
  required_version = ">= 1.5"
}

# Configure the default AWS Provider
provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn = var.provider_role_arn
  }
  default_tags {
    tags = {
      "Owner"       = "Storm Mobility"
      "Project"     = "ImageFactory2"
      "Environment" = "Production"
    }
  }
}

# Configure the tooling account provider for the us-east-1 region
provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
  assume_role {
    role_arn = var.provider_role_arn
  }
  default_tags {
    tags = {
      "Owner"       = "Storm Mobility"
      "Project"     = "ImageFactory2"
      "Environment" = "Production"
    }
  }
}
