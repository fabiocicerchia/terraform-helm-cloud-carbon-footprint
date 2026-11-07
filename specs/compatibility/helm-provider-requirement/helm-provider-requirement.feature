@domain:compatibility @area:helm-provider-requirement @from:terraform-helm-cloud-carbon-footprint/versions
Feature: Depending on the Helm provider
  Tells operators which Helm provider the module installs and which versions it accepts, so they can line up their own provider pins.

  Background:
    Given the operator has a configuration that calls the Cloud Carbon Footprint module

  @id:compatibility.helm-provider-requirement.001 @rule:compatibility.providers.helm-2-0-or-newer @inferred @source:versions.tf#terraform @questionable
  Scenario Outline: The module needs the HashiCorp Helm provider at version 2.0 or newer
    Given the operator's configuration allows Helm provider version <pinned>
    When the operator initialises the configuration
    Then provider selection <outcome>

    Examples:
      | pinned | outcome                                                            |
      | 1.3.2  | fails because no hashicorp/helm version satisfies both constraints |
      | 2.0.0  | installs hashicorp/helm 2.0.0                                      |
      | 2.17.0 | installs hashicorp/helm 2.17.0                                     |
      | 3.0.2  | installs hashicorp/helm 3.0.2                                      |
