variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "release_name" {
  description = "Helm release name for Cloud Carbon Footprint"
  type        = string
  default     = "cloudcarbonfootprint"
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
  default     = <<-EOT
    client:
      deployment:
        replicaCount: 1
        image:
          repository: docker.io/cloudcarbonfootprint/client
          tag: release-2024-02-11
      ingress:
        enabled: false
        # Uncomment to enable ingress
        # enabled: true
        # className: "nginx"
        # hosts:
        #   - host: ccf.example.com
        #     paths:
        #       - path: /
        #         pathType: Prefix
    
    api:
      deployment:
        replicaCount: 1
        image:
          repository: docker.io/cloudcarbonfootprint/api
          tag: release-2024-02-11
      # Configure your cloud provider credentials here
      configmap:
        # AWS Configuration
        # AWS_USE_BILLING_DATA: "true"
        # AWS_BILLING_ACCOUNT_ID: "your-account-id"
        # AWS_BILLING_ACCOUNT_NAME: "your-account-name"
        # AWS_ATHENA_DB_NAME: "your-athena-db"
        # AWS_ATHENA_DB_TABLE: "your-table"
        # AWS_ATHENA_REGION: "us-east-1"
        # AWS_ATHENA_QUERY_RESULT_LOCATION: "s3://your-bucket/results/"
        
        # GCP Configuration
        # GCP_USE_BILLING_DATA: "true"
        # GCP_BILLING_PROJECT_ID: "your-project-id"
        # GCP_BILLING_PROJECT_NAME: "your-project-name"
        # GCP_BIG_QUERY_TABLE: "billing_data.gcp_billing_export_v1"
        
        # Azure Configuration
        # AZURE_USE_BILLING_DATA: "true"
        # AZURE_CLIENT_ID: "your-client-id"
        # AZURE_CLIENT_SECRET: "your-client-secret"
        # AZURE_TENANT_ID: "your-tenant-id"
  EOT
}
