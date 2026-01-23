module "cloudcarbonfootprint" {
  source = "../"

  release_name    = var.release_name
  namespace       = var.namespace
  chart_version   = var.chart_version
  values          = var.values
}
