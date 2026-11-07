@domain:deployment @area:release-installation @from:terraform-helm-cloud-carbon-footprint/variables
Feature: Naming the Cloud Carbon Footprint release
  Lets an operator choose the Helm release name, or rely on a sensible default, so the deployment can be found and managed in the cluster.

  Background:
    Given the operator uses the Cloud Carbon Footprint module

  @id:deployment.release-installation.001 @rule:deployment.release-installation.default-release-name @inferred @source:variables.tf#release_name
  Scenario Outline: The release is named cloud-carbon-footprint unless the operator names it
    Given the operator has set the release name to <given name>
    When the operator applies the configuration
    Then a Helm release named <release name> is installed

    Examples:
      | given name | release name           |
      | (nothing)  | cloud-carbon-footprint |
      | ccf-prod   | ccf-prod               |
