@domain:deployment @area:chart-versioning @from:terraform-helm-cloud-carbon-footprint/variables
Feature: Pinning the chart version
  Lets an operator pin the Cloud Carbon Footprint chart to a known version, or take the latest one by leaving the version empty.

  Background:
    Given the operator uses the Cloud Carbon Footprint module

  @id:deployment.chart-versioning.001 @rule:deployment.chart-versioning.empty-version-means-latest @inferred @source:variables.tf#chart_version
  Scenario Outline: An empty chart version installs the latest chart, a given version pins it
    Given the operator has set the chart version to <chart version>
    When the operator applies the configuration
    Then the release is installed from <installed chart>

    Examples:
      | chart version | installed chart            |
      | (nothing)     | the latest available chart |
      | ""            | the latest available chart |
      | 0.1.0         | chart version 0.1.0        |
