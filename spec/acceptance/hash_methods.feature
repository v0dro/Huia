Feature: Core Hash methods

  Scenario: 'keys' returns an array of keys
    Given the following source:
    """
    { "a" : 1, "b" : 2, "c" : 3 }.keys
    """
    When it is evaluated
    Then the result is '[ "a", "b", "c" ]'

  Scenario: 'values' returns an array of values
    Given the following source:
    """
    { "a" : 1, "b" : 2, "c" : 3 }.values
    """
    When it is evaluated
    Then the result is '[ 1, 2, 3 ]'

  Scenario: 'size' returns the number of pairs in the hash
    Given the following source:
    """
    { "a" : 1, "b" : 2, "c" : 3 }.size
    """
    When it is evaluated
    Then the result is '3'

  Scenario: 'inspect' displays a human-readable version of the hash
    Given the following source:
    """
    { "a" : 1, "b" : 2, "c" : 3 }.inspect
    """
    When it is evaluated
    Then the result is '"{ \"a\" : 1, \"b\" : 2, \"c\" : 3 }"'
