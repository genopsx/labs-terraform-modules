output "grafana_url" {
  value = var.loki_stack_enabled ? module.loki-stack.grafana_url : null
}

output "kubeshark_url" {
  value = var.kubeshark_enabled ? module.kubeshark[0].kubeshark_url : null
}

output "jaeger_url" {
  value = var.jaeger_enabled ? module.jaeger[0].jaeger_url : null
}

output "grafana_url" {
  value = var.kube_prometheus_stack_enabled ? module.kube-prometheus-stack[0].grafana_url : null
}

output "prometheus_url" {
  value = var.kube_prometheus_stack_enabled ? module.kube-prometheus-stack[0].prometheus_url : null
}

output "alertmanager_url" {
  value = var.kube_prometheus_stack_enabled ? module.kube-prometheus-stack[0].alertmanager_url : null
}
