Feature: Closure core methods

  Scenario Outline: 'argumentNames' returns an array of arguments
    Given the following source:
    """
    TestClosure = Closure.create:<arguments>
      true

    TestClosure.argumentNames
    """
    When it is evaluated
    Then the result is '<result>'
    Examples:
      | arguments    | result           |
      |              | []               |
      |  \|one\|     | [ "one" ]        |
      |  \|one,two\| | [ "one", "two" ] |

  Scenario Outline: 'takesArguments?' returns true only when there are arguments present.
    Given the following source:
    """
    TestClosure = Closure.create:<arguments>
      true

    TestClosure.takesArguments?
    """
    When it is evaluated
    Then the result is '<result>'
    Examples:
      | arguments    | result  |
      |              | false   |
      |  \|one\|     | true    |
      |  \|one,two\| | true    |

  Scenario: 'fileName' returns the correct value
    Given the following source:
    """
    TestClosure = Closure.create:
      true

    TestClosure.fileName
    """
    When it is evaluated
    Then the result is '"(eval)"'

  Scenario: 'lineNumber' returns the correct value
    Given the following source:
    """
    TestClosure = Closure.create:
      true

    TestClosure.lineNumber
    """
    When it is evaluated
    Then the result is '1'
