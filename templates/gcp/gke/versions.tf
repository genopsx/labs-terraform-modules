terraform {
  required_version = ">= 0.13"
  required_providers {
    gcp = {
      source  = "hashicorp/gcp"
      version = "~> 3.5.0"
    }
  }
}
