Feature: Nil Methods

  Scenario: 'inspect' converts returns a string
    Given the following source:
    """
    nil.inspect
    """
    When it is evaluated
    Then the result is '"nil"'

  Scenario: 'toString' returns a string
    Given the following source:
    """
    nil.toString
    """
    When it is evaluated
    Then the result is '""'

  Scenario: 'truthy?' is nil
    Given the following source:
    """
    nil.truthy?
    """
    When it is evaluated
    Then the result is 'false'

  Scenario: 'unaryNot' is true
    Given the following source:
    """
    nil.unaryNot
    """
    When it is evaluated
    Then the result is 'true'
