Feature: False Methods

  Scenario: 'inspect' converts the boolean to a string.
    Given the following source:
    """
    false.inspect
    """
    When it is evaluated
    Then the result is '"false"'

  Scenario: 'toString' converts the boolean to a string.
    Given the following source:
    """
    false.toString
    """
    When it is evaluated
    Then the result is '"false"'

  Scenario: 'truthy?' is false
    Given the following source:
    """
    false.truthy?
    """
    When it is evaluated
    Then the result is 'false'

  Scenario: 'unaryNot' is true
    Given the following source:
    """
    false.unaryNot
    """
    When it is evaluated
    Then the result is 'true'
