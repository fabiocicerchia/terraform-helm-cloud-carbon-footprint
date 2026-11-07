@domain:service-access @area:service-endpoints @from:terraform-helm-cloud-carbon-footprint/outputs
Feature: Finding the in-cluster service addresses
  Gives an operator the in-cluster addresses of the Cloud Carbon Footprint dashboard and API, so other workloads can reach them without looking anything up.

  Background:
    Given Cloud Carbon Footprint has been deployed with this module

  @id:service-access.service-endpoints.001 @rule:service-access.service-endpoints.addresses-from-release-and-namespace @inferred @source:outputs.tf#client_service_url
  Scenario Outline: The dashboard and API addresses follow the release name and namespace
    Given the operator set the release name to "<release_name>"
    And the operator set the namespace to "<namespace>"
    When the operator reads the module outputs
    Then the "client_service_url" output is "<client_url>"
    And the "api_service_url" output is "<api_url>"

    Examples:
      | release_name           | namespace              | client_url                                                             | api_url                                                             |
      | cloud-carbon-footprint | cloud-carbon-footprint | cloud-carbon-footprint-client.cloud-carbon-footprint.svc.cluster.local | cloud-carbon-footprint-api.cloud-carbon-footprint.svc.cluster.local |
      | ccf-prod               | sustainability         | ccf-prod-client.sustainability.svc.cluster.local                       | ccf-prod-api.sustainability.svc.cluster.local                       |

  @id:service-access.service-endpoints.002 @rule:service-access.service-endpoints.addresses-ignore-chart-overrides @inferred @source:outputs.tf#api_service_url @questionable
  Scenario: The addresses do not change when custom values rename the chart's services
    Given the operator passed custom values that rename the chart's services, for example fullnameOverride "carbon"
    And the release name is "cloud-carbon-footprint" in namespace "cloud-carbon-footprint"
    When the operator reads the module outputs
    Then the "client_service_url" output is still "cloud-carbon-footprint-client.cloud-carbon-footprint.svc.cluster.local"
    And the "api_service_url" output is still "cloud-carbon-footprint-api.cloud-carbon-footprint.svc.cluster.local"
