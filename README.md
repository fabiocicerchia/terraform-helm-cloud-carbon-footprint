# Terraform Module for Cloud Carbon Footprint

Terraform module to deploy Cloud Carbon Footprint on Kubernetes using Helm.

## Why This Matters

Cloud infrastructure abstracts away the physical reality of data centres, making it easy to overlook the environmental cost of compute resources. Without visibility into carbon emissions, it's impossible to make informed decisions about sustainability.

Cloud Carbon Footprint provides:

- ☁️ **Multi-cloud carbon visibility** across AWS, GCP, and Azure
- 📊 **Historical emissions tracking** to measure progress over time
- 💰 **Cost-to-carbon correlation** showing the environmental price of spending
- 🔍 **Recommendations** for reducing cloud carbon footprint
- 📈 **ESG reporting data** in quantifiable metrics (kWh, metric tons CO₂e)

By visualising the carbon impact of cloud usage, teams can make data-driven decisions to optimise for both cost and sustainability—turning vague environmental goals into concrete, actionable insights.

## Overview

Cloud Carbon Footprint is an application that estimates the energy (kilowatt hours) and carbon emissions (metric tons CO2e) of public cloud provider utilisation. Key features include:

- **Multi-Cloud Support**: Supports AWS, GCP, and Azure
- **Energy & Emissions Tracking**: Monitors kilowatt hours and CO2e emissions
- **Cost Analysis**: Correlates carbon footprint with cloud costs
- **Visual Dashboard**: Web-based interface for viewing metrics
- **Recommendations**: Provides insights for reducing carbon footprint
- **Historical Data**: Tracks emissions over time

## Quick Start

```hcl
module "cloud_carbon_footprint" {
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  release_name    = "cloud-carbon-footprint"
  namespace       = "cloud-carbon-footprint"
}
```

## Inputs

| Name            | Description                                       | Type     | Default                    | Required |
| --------------- | ------------------------------------------------- | -------- | -------------------------- | :------: |
| `release_name`  | Helm release name for Cloud Carbon Footprint      | `string` | `"cloud-carbon-footprint"` | no       |
| `namespace`     | Kubernetes namespace for Cloud Carbon Footprint   | `string` | `"cloud-carbon-footprint"` | no       |
| `chart_version` | Helm chart version (empty string for latest)      | `string` | `""`                       | no       |
| `values`        | Helm values for Cloud Carbon Footprint deployment | `any`    | See default values         | no       |

## Outputs

| Name                 | Description                                                   |
| -------------------- | ------------------------------------------------------------- |
| `namespace`          | Kubernetes namespace where Cloud Carbon Footprint is deployed |
| `release_name`       | Helm release name of Cloud Carbon Footprint                   |
| `chart_version`      | Chart version of Cloud Carbon Footprint deployment            |
| `client_service_url` | Internal URL for Cloud Carbon Footprint client service        |
| `api_service_url`    | Internal URL for Cloud Carbon Footprint API service           |

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster
- Cloud provider credentials (AWS, GCP, or Azure)
- Cloud billing data access configured

## Usage

### Basic Deployment

```hcl
module "cloud_carbon_footprint" {
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  namespace = "cloud-carbon-footprint"
}
```

### AWS Configuration

```hcl
module "cloud_carbon_footprint" {
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  namespace = "cloud-carbon-footprint"
  values = {
    api = {
      configmap = {
        AWS_USE_BILLING_DATA                = "true"
        AWS_BILLING_ACCOUNT_ID              = "123456789012"
        AWS_BILLING_ACCOUNT_NAME            = "My AWS Account"
        AWS_ATHENA_DB_NAME                  = "athenacurcfn_my_cur"
        AWS_ATHENA_DB_TABLE                 = "my_cur"
        AWS_ATHENA_REGION                   = "us-east-1"
        AWS_ATHENA_QUERY_RESULT_LOCATION    = "s3://aws-athena-query-results-123456789012-us-east-1/"
      }
    }
  }
}
```

### GCP Configuration

```hcl
module "cloud_carbon_footprint" {
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  namespace = "cloud-carbon-footprint"
  values = {
    api = {
      configmap = {
        GCP_USE_BILLING_DATA           = "true"
        GCP_BILLING_PROJECT_ID         = "my-project-id"
        GCP_BILLING_PROJECT_NAME       = "My GCP Project"
        GCP_BIG_QUERY_TABLE            = "billing_data.gcp_billing_export_v1"
        GOOGLE_APPLICATION_CREDENTIALS = "/app/credentials/gcp-credentials.json"
      }
    }
  }
}
```

### Azure Configuration

```hcl
module "cloud_carbon_footprint" {
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  namespace = "cloud-carbon-footprint"
  values = {
    api = {
      configmap = {
        AZURE_USE_BILLING_DATA = "true"
        AZURE_CLIENT_ID        = "your-client-id"
        AZURE_CLIENT_SECRET    = "your-client-secret"
        AZURE_TENANT_ID        = "your-tenant-id"
        AZURE_SUBSCRIPTION_ID  = "your-subscription-id"
      }
    }
  }
}
```

### With Ingress Enabled

```hcl
module "cloud_carbon_footprint" {
  source = "= "cloud-carbon-footprint"
  values = {
    client = {
      ingress = {
        enabled   = true
        className = "nginx"
        hosts = [{
          host = "ccf.example.com"
          paths = [{
            path     = "/"
            pathType = "Prefix"
          }]
        }]
        tls = [{
          secretName = "ccf-tls"
          hosts      = ["ccf.example.com"]
        }]
      }
    }
  }       hosts:
              - ccf.example.com
  EOT
}
```

### Pin Chart Version

```hcl
module "cloud_carbon_footprint" {
  source = "fabiocicerchia/cloud-carbon-footprint/helm"

  chart_version   = "1.0.0"
}
```

## Verify Deployment

```bash
# Check Cloud Carbon Footprint deployments
kubectl get pods -n cloud-carbon-footprint

# Check services
kubectl get svc -n cloud-carbon-footprint

# Access the client UI (if using port-forward)
kubectl port-forward -n cloud-carbon-footprint svc/cloud-carbon-footprint-client 8080:80

# Then open browser to http://localhost:8080
```

## Configuration

### Cloud Provider Setup

Before deploying, you need to:

1. **AWS**:
   - Enable Cost and Usage Reports (CUR)
   - Create an Athena database for querying billing data
   - Configure IAM permissions for accessing billing data

1. **GCP**:
   - Enable Cloud Billing export to BigQuery
   - Create a service account with BigQuery access
   - Provide service account credentials

1. **Azure**:
   - Create an Azure App Registration
   - Grant appropriate billing reader permissions
   - Provide client credentials

### Environment Variables

The API accepts various environment variables for configuration:

- **AWS**: `AWS_USE_BILLING_DATA`, `AWS_BILLING_ACCOUNT_ID`, `AWS_ATHENA_*`
- **GCP**: `GCP_USE_BILLING_DATA`, `GCP_BILLING_PROJECT_ID`, `GOOGLE_APPLICATION_CREDENTIALS`
- **Azure**: `AZURE_USE_BILLING_DATA`, `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_TENANT_ID`

## Resources

- [Cloud Carbon Footprint](https://www.cloudcarbonfootprint.org/)
- [Documentation](https://www.cloudcarbonfootprint.org/docs/introduction)
- [Methodology](https://www.cloudcarbonfootprint.org/docs/methodology)
- [GitHub Repository](https://github.com/cloud-carbon-footprint/cloud-carbon-footprint)

## Make targets

`make help` lists them. Every repository in this estate exposes the same eight
verbs, so you do not have to read a Makefile to find out how to build or test it
(FC-GEN-057).

| Verb      | What it does here                                    |
| --------- | ---------------------------------------------------- |
| `setup`   | Install the pre-commit hook                          |
| `install` | Download the providers this module pins              |
| `lint`    | `pre-commit run --all-files` — the whole gate        |
| `format`  | `terraform fmt -recursive`                           |
| `test`    | `terraform validate` on the module and every example |
| `analyze` | `tflint --recursive`                                 |

### Not applicable

Two verbs have no meaning for a Terraform module. They exit 0 and say so rather
than pretending to work (FC-GEN-058):

- `build` — nothing is compiled; the module is consumed from source.
- `run` — a module is instantiated by a root module, never executed directly.

## License

MIT
