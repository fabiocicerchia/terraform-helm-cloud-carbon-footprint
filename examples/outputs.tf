output "namespace" {
  description = "Kubernetes namespace where Cloud Carbon Footprint is deployed"
  value       = module.cloudcarbonfootprint.namespace
}

output "release_name" {
  description = "Helm release name of Cloud Carbon Footprint"
  value       = module.cloudcarbonfootprint.release_name
}

output "chart_version" {
  description = "Chart version of Cloud Carbon Footprint deployment"
  value       = module.cloudcarbonfootprint.chart_version
}

output "client_service_url" {
  description = "Internal URL for Cloud Carbon Footprint client service"
  value       = module.cloudcarbonfootprint.client_service_url
}

output "api_service_url" {
  description = "Internal URL for Cloud Carbon Footprint API service"
  value       = module.cloudcarbonfootprint.api_service_url
}
