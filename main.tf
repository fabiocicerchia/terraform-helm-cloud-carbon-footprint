resource "helm_release" "cloudcarbonfootprint" {
  name       = var.release_name
  repository = "${path.module}/.upstream/helm/charts"
  chart      = "cloud-carbon-footprint"
  version    = var.chart_version != "" ? var.chart_version : null

  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  values = [yamlencode(var.values)]
}
