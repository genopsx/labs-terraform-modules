terraform {
  required_version = ">= 0.13"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.5.0"
    }
  }
}
# In order to deploy resources in grafana, you need to provide the url and token
# provider "grafana" {
#   url  = local.grafana_auths["grafana_url"]
#   auth = local.grafana_auths["grafana_token"]
# }
