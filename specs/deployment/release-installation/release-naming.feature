@domain:deployment @area:release-installation @from:terraform-helm-cloud-carbon-footprint/variables
Feature: Naming and placing the Cloud Carbon Footprint release
  Lets an operator choose the Helm release name and namespace, or rely on a sensible default, so the deployment can be found and managed in the cluster.

  Background:
    Given the operator uses the Cloud Carbon Footprint module

  @id:deployment.release-installation.001 @rule:deployment.release-installation.default-release-name @inferred @source:variables.tf#release_name
  Scenario Outline: The release is named and placed by default unless the operator chooses a name and namespace
    Given the operator has set the release name to <given name>
    And the operator has set the namespace to <given namespace>
    When the operator applies the configuration
    Then a Helm release named <release name> is installed in the <namespace> namespace

    Examples:
      | given name | given namespace | release name           | namespace              |
      | (nothing)  | (nothing)       | cloud-carbon-footprint | cloud-carbon-footprint |
      | ccf-prod   | sustainability  | ccf-prod               | sustainability         |
