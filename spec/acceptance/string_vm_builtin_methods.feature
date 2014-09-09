Feature: String VM core builtin methods

  Scenario: `concat:` returns two strings concatenated together without modifying the originals
    Given the following source:
    """
    a = "a"
    b = "b"
    c = a.concat: b
    [a, b, c]
    """
    When it is evaluated
    Then the result is:
    """
    [ "a", "b", "ab" ]
    """
