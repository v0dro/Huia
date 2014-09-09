Feature: True Methods

  Scenario: 'inspect' converts the boolean to a string.
    Given the following source:
    """
    true.inspect
    """
    When it is evaluated
    Then the result is '"true"'

  Scenario: 'toString' converts the boolean to a string.
    Given the following source:
    """
    true.toString
    """
    When it is evaluated
    Then the result is '"true"'

  Scenario: 'truthy?' is true
    Given the following source:
    """
    true.truthy?
    """
    When it is evaluated
    Then the result is 'true'

  Scenario: 'unaryNot' is true
    Given the following source:
    """
    true.unaryNot
    """
    When it is evaluated
    Then the result is 'false'
