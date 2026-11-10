@domain:compatibility @area:terraform-opentofu-support @from:terraform-helm-cloud-carbon-footprint/versions
Feature: Running the module on Terraform or OpenTofu
  Lets operators know which Terraform and OpenTofu releases can apply the module before they adopt it.

  Background:
    Given the operator has a configuration that calls the Cloud Carbon Footprint module

  @id:compatibility.terraform-opentofu-support.001 @rule:compatibility.cli.minimum-terraform-1-0 @inferred @source:versions.tf#terraform
  Scenario Outline: The module runs on Terraform 1.0 or newer and on OpenTofu, and is refused by older Terraform
    Given the operator's tool is <tool> version <version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | tool      | version | outcome                                                     |
      | Terraform | 0.15.5  | is refused with an unsupported Terraform Core version error |
      | Terraform | 1.0.0   | succeeds                                                    |
      | Terraform | 1.9.8   | succeeds                                                    |
      | OpenTofu  | 1.6.0   | succeeds                                                    |
