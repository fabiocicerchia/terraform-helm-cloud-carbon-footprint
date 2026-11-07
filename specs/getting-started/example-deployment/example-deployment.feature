@domain:getting-started @area:example-deployment @from:examples/examples
Feature: Deploying Cloud Carbon Footprint from the example
  Gives an operator trying the module a ready-to-apply configuration that deploys Cloud Carbon Footprint with default settings and shows where their own Helm values go.

  Background:
    Given Given the operator has a Kubernetes cluster that Terraform can reach through the Helm provider

  @id:getting-started.example-deployment.001 @rule:getting-started.example.deploys-default-release @inferred @source:examples/main.tf#cloud_carbon_footprint
  Scenario: The example deploys Cloud Carbon Footprint under its default name and namespace with the latest chart
    Given the operator has not changed the example configuration
    And no namespace named "cloud-carbon-footprint" exists in the cluster
    When the operator applies the example configuration
    Then a Helm release named "cloud-carbon-footprint" is installed
    And the release runs in the namespace "cloud-carbon-footprint", which is created for it
    And the release uses the latest bundled Cloud Carbon Footprint chart, because the example pins no chart version

  @id:getting-started.example-deployment.002 @rule:getting-started.example.no-custom-values-by-default @inferred @source:examples/main.tf#cloud_carbon_footprint
  Scenario: The example applies no custom Helm values until the operator adds them
    Given the operator has not uncommented the custom values block in the example
    When the operator applies the example configuration
    Then Cloud Carbon Footprint is deployed with the chart's default settings
    And the example shows a commented values block where the operator can add custom Helm values
