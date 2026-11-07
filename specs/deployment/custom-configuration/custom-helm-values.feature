@domain:deployment @area:custom-configuration @from:terraform-helm-cloud-carbon-footprint/variables
Feature: Tailoring the deployment with Helm values
  Lets an operator pass their own Helm values to the Cloud Carbon Footprint chart, so they can tailor the deployment without forking the module.

  Background:
    Given the operator uses the Cloud Carbon Footprint module

  @id:deployment.custom-configuration.001 @rule:deployment.custom-configuration.values-passed-to-chart @inferred @source:variables.tf#values
  Scenario Outline: Values the operator supplies reach the chart, and the chart's defaults apply when none are given
    Given the operator has set the Helm values to <values>
    When the operator applies the configuration
    Then the chart is rendered with <effective configuration>

    Examples:
      | values                         | effective configuration                           |
      | (nothing)                      | the chart's own default values                    |
      | { api = { replicaCount = 2 } } | the chart defaults with api.replicaCount set to 2 |
