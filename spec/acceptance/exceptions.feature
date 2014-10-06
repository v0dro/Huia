Feature: Closures can rescue exceptions and ensure blocks.

  Scenario: We can rescue specific exceptions.
    Given the following source:
    """
    result = nil

    Exception = Huia.requireCore: 'exception'

    TestException = Exception.extend:
      set: 'name' to: 'TestException'

    testClosure = Closure.create:
      raiseException: TestException withMessage: 'I exploded.'

    testClosure.rescueFrom: TestException with: |exception|
      result = exception

    testClosure.callWithSelf: self andArgs: []

    result
    """
    When it is evaluated
    Then the result includes '<Object(TestException)#'

  Scenario: We can ensure certain blocks are run even on failure:
    Given the following source:
    """
    result = nil

    Exception = Huia.requireCore: 'exception'

    testClosure = Closure.create:
      raiseException: Exception withMessage: 'I exploded.'

    testClosure.rescueFrom: Exception with: |exception|
      exception

    testClosure.ensure:
      result = 'ensured'

    testClosure.callWithSelf: self andArgs: []

    result
    """
    When it is evaluated
    Then the result is '"ensured"'
