@domain:deployment @area:namespace-placement @from:terraform-helm-cloud-carbon-footprint/variables
Feature: Choosing the deployment namespace
  Lets an operator choose the Kubernetes namespace Cloud Carbon Footprint runs in, with a default when none is given.

  Background:
    Given the operator uses the Cloud Carbon Footprint module

  @id:deployment.namespace-placement.001 @rule:deployment.namespace-placement.default-namespace @inferred @source:variables.tf#namespace
  Scenario Outline: Cloud Carbon Footprint runs in the cloud-carbon-footprint namespace unless the operator picks another
    Given the operator has set the namespace to <given namespace>
    When the operator applies the configuration
    Then the release is installed in the <namespace> namespace

    Examples:
      | given namespace | namespace              |
      | (nothing)       | cloud-carbon-footprint |
      | sustainability  | sustainability         |
