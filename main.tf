resource "helm_release" "cloud_carbon_footprint" {
  name       = var.release_name
  repository = "${path.module}/.upstream/helm/charts/"
  chart      = "cloud-carbon-footprint"
  version    = var.chart_version != "" ? var.chart_version : null
  
  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  wait          = false
  wait_for_jobs = false
  timeout       = 30
  
  values = [yamlencode(var.values)]
}
