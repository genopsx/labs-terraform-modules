resource "helm_release" "kube-prometheus-stack" {
  name             = "kube-prometheus-stack"
  namespace        = var.kube_prometheus_stack_namespace
  chart            = "kube-prometheus-stack"
  version          = var.kube_prometheus_stack_chart_version
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = true
  values           = [local.base_values]

  dynamic "set" {
    for_each = var.extra_values
    content {
      name  = set.key
      value = set.value
    }
  }
}

resource "grafana_dashboard" "nginx_slo" {
  config_json = jsonencode({
    title = "NGINX SLO Dashboard"
    panels = [
      {
        title      = "Request Success Rate"
        type       = "gauge"
        datasource = "prometheus"
        targets = [
          {
            expr         = "sum(rate(http_requests_total{code!~\"5..\"}[1m])) / sum(rate(http_requests_total[1m]))"
            legendFormat = "Success Rate"
          }
        ]
        fieldConfig = {
          defaults = {
            thresholds = {
              mode = "absolute"
              steps = [
                { color = "red", value = 0 },
                { color = "yellow", value = 0.99 },
                { color = "green", value = 1 },
              ]
            }
          }
        }
      }
    ]
  })
  overwrite = true # Overwrite if the dashboard already exists
}
