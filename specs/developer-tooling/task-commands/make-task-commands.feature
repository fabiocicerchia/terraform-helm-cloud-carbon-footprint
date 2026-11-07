@domain:developer-tooling @area:task-commands @from:terraform-helm-cloud-carbon-footprint/makefile
Feature: Running the repository's task commands
  Gives contributors one standard, self-documenting set of make commands, so no command silently does nothing.

  Background:
    Given the contributor is in a checkout of the module

  @id:developer-tooling.task-commands.001 @rule:devtooling.tasks.bare-make-shows-help @inferred @source:Makefile#help
  Scenario: Running make with no command lists every command and what it does
    When the contributor runs make with no command
    Then each command (help, setup, install, lint, format, test, analyze, build, run) is printed on its own line
    And each line shows the command's one-line description, such as "test  Validate the module and its examples"

  @id:developer-tooling.task-commands.002 @rule:devtooling.tasks.not-applicable-commands-explain-why @inferred @source:Makefile#build
  Scenario Outline: The build and run commands say why they do nothing
    When the contributor runs make <command>
    Then the command finishes with success
    And the message "<message>" is shown
    And the contributor is pointed to "See README > Not applicable."

    Examples:
      | command | message                                                                  |
      | build   | Nothing to build: this is a Terraform module, consumed from source.      |
      | run     | Nothing to run: a module is called by a root module, never run directly. |

  @id:developer-tooling.task-commands.003 @rule:devtooling.tasks.analyze-refuses-without-tflint @inferred @source:Makefile#analyze
  Scenario: Static analysis refuses to run when tflint is not installed
    Given tflint is not installed
    When the contributor runs make analyze
    Then "analyze needs tflint: https://github.com/terraform-linters/tflint" is shown on the error output
    And the command fails with exit status 69
    And no analysis is run
