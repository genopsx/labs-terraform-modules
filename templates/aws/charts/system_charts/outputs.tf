output "cluster_secret_store_ref_name" {
  value = module.external_secrets[0].cluster_secret_store_ref_name
}

output "polaris_url" {
  value = var.polaris_enabled ? module.polaris.palaris_url : null
}

output "goldilocks_url" {
  value = var.goldilocks_enabled ? module.goldilocks.goldilocks_url : null
}
