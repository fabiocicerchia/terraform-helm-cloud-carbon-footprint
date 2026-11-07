@domain:service-access @area:release-details @from:terraform-helm-cloud-carbon-footprint/outputs
Feature: Reporting what was deployed
  Lets an operator see the namespace, release name and chart version Cloud Carbon Footprint was actually deployed with, so calling configurations and runbooks can reference them.

  Background:
    Given Cloud Carbon Footprint has been deployed with this module

  @id:service-access.release-details.001 @rule:service-access.release-details.reports-namespace-and-release-name @inferred @source:outputs.tf#namespace
  Scenario Outline: The deployed namespace and release name are reported
    Given the operator set the release name to "<release_name>"
    And the operator set the namespace to "<namespace>"
    When the operator reads the module outputs
    Then the "release_name" output is "<release_name>"
    And the "namespace" output is "<namespace>"

    Examples:
      | release_name           | namespace              |
      | cloud-carbon-footprint | cloud-carbon-footprint |
      | ccf-prod               | sustainability         |

  @id:service-access.release-details.002 @rule:service-access.release-details.reports-chart-version @inferred @source:outputs.tf#chart_version
  Scenario Outline: The chart version of the deployment is reported
    Given the operator <pinning>
    When the operator reads the module outputs
    Then the "chart_version" output is <reported>

    Examples:
      | pinning                             | reported                                    |
      | pinned the chart version to "3.1.0" | "3.1.0"                                     |
      | left the chart version empty        | the version of the chart that was installed |
