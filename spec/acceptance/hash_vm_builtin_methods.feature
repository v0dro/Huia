Feature: Core Hash VM builtin methods

  Scenario: 'at:' returns the value at a given index of the hash
    Given the following source:
    """
    { "a" : 1, "b" : 2, "c" : 3 }.at: "b"
    """
    When it is evaluated
    Then the result is '2'

  Scenario: 'at:set:' sets the value at a given index of the hash
    Given the following source:
    """
    hash = { "a" : 1, "b" : 2, "c" : 3 }
    hash.at: "b" set: 99
    hash
    """
    When it is evaluated
    Then the result is '{ "a" : 1, "b" : 99, "c" : 3 }'
