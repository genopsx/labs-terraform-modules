terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.0"
    }
    cilium = {
      source  = "littlejo/cilium"
      version = ">= 0.1.10"
    }
  }
  required_version = "> 1.4"
}
