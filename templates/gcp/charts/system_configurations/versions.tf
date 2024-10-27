terraform {
  required_version = ">= 0.13"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5.0"
    }
  }
}
