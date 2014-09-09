Feature: Core String methods

  Scenario: `toString` returns self
    Given the following source '"abc".toString'
    When it is evaluated
    Then the result is '"abc"'

  Scenario: `push:` modifies the LHS string by concatenating the RHS
    Given the following source:
    """
    a = "a"
    b = "b"
    c = a.push: b
    [a, b, c]
    """
    When it is evaluated
    Then the result is:
    """
    [ "ab", "b", "ab" ]
    """

  Scenario: `inspect` returns an escapted version of the string
    Given the following source:
    """
    "abc
    def"
    """
    When it is evaluated
    Then the result is '"abc\ndef"'
