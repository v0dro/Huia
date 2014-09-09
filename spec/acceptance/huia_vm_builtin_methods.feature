Feature: Huia VM core builtin methods.

  Scenario: `requireCore:` can load core classes.
    Given the following source:
    """
    Huia.requireCore: 'string'
    """
    When it is evaluated
    Then the result is a class

  Scenario: `requireFile:` can load arbitrary huia files.
    Given the following source:
    """
    Hello = Huia.requireFile: 'spec/fixtures/hello_world'
    Hello.whom: "World"
    """
    When it is evaluated
    Then the result is '"Hello World!"'
