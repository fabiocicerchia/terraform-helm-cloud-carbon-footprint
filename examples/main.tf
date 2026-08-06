terraform {
  required_version = ">= 1.0"
}

module "cloud_carbon_footprint" {
  source = "../"

  release_name  = "cloud-carbon-footprint"
  namespace     = "cloud-carbon-footprint"
  chart_version = ""

  # values = yamlencode({
  #   # Add your custom values here
  # })
}
