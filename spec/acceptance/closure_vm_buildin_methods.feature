Feature: Closure VM builtin methods

  Scenario: 'create:' and 'callWithSelf:andArgs' work
    Given the following source:
    """
    TestClosure = Closure.create:
      "test"

    TestClosure.callWithSelf: self andArgs: []
    """
    When it is evaluated
    Then the result is '"test"'
