# Specifications of terraform-helm-cloud-carbon-footprint

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Compatibility
The tool and provider versions the module supports.

- **Helm provider requirement**: [Depending on the Helm provider](compatibility/helm-provider-requirement/helm-provider-requirement.feature) (1)
- **Terraform and OpenTofu support**: [Running the module on Terraform or OpenTofu](compatibility/terraform-opentofu-support/terraform-opentofu-support.feature) (1)

## Deployment
Installing Cloud Carbon Footprint onto a Kubernetes cluster as a Helm release.

- **Chart versioning**: [Pinning the chart version](deployment/chart-versioning/chart-version-pinning.feature) (1)
- **Custom configuration**: [Tailoring the deployment with Helm values](deployment/custom-configuration/custom-helm-values.feature) (1)
- **Release installation**: [Naming and placing the Cloud Carbon Footprint release](deployment/release-installation/release-naming.feature) (1)

## Developer tooling
Commands and checks maintainers use to build, verify and keep the module tidy.

- **Task commands**: [Running the repository's task commands](developer-tooling/task-commands/make-task-commands.feature) (3)

## Getting started
Ready-to-copy examples that show how to use the module.

- **Example deployment**: [Deploying Cloud Carbon Footprint from the example](getting-started/example-deployment/example-deployment.feature) (1)

## Service access
Information the module returns so other infrastructure can find and reach the deployed product.

- **Release details**: [Reporting what was deployed](service-access/release-details/release-details.feature) (2)
- **Service endpoints**: [Finding the in-cluster service addresses](service-access/service-endpoints/service-endpoints.feature) (2)
