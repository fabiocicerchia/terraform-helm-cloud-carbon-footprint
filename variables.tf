variable "release_name" {
  description = "Helm release name for Cloud Carbon Footprint"
  type        = string
  default     = "cloud-carbon-footprint"
}

variable "namespace" {
  description = "Kubernetes namespace for Cloud Carbon Footprint"
  type        = string
  default     = "cloud-carbon-footprint"
}

variable "chart_version" {
  description = "Cloud Carbon Footprint Helm chart version (empty string for latest)"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for Cloud Carbon Footprint deployment"
  type        = any
  default     = {}
}
