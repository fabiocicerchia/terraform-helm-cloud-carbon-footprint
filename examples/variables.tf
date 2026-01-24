variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

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
  description = "Cloud Carbon Footprint Helm chart version"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for Cloud Carbon Footprint deployment"
  type        = any
  default     = {}
}
