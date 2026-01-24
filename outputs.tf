output "namespace" {
  description = "Kubernetes namespace where Cloud Carbon Footprint is deployed"
  value       = helm_release.cloud_carbon_footprint.namespace
}

output "release_name" {
  description = "Helm release name of Cloud Carbon Footprint"
  value       = helm_release.cloud_carbon_footprint.name
}

output "chart_version" {
  description = "Chart version of Cloud Carbon Footprint deployment"
  value       = helm_release.cloud_carbon_footprint.version
}

output "client_service_url" {
  description = "Internal URL for Cloud Carbon Footprint client service"
  value       = "${var.release_name}-client.${var.namespace}.svc.cluster.local"
}

output "api_service_url" {
  description = "Internal URL for Cloud Carbon Footprint API service"
  value       = "${var.release_name}-api.${var.namespace}.svc.cluster.local"
}
