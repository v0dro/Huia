Feature: Closures can rescue exceptions and ensure blocks.

  Scenario: We can raise exceptions.
    Given the following source:
    """
    raiseException: (Huia.requireCore: 'exception') withMessage: 'Explosion'
    """
    When it is safely evaluated
    Then an exception is raised
    And the exception message is 'Explosion'

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

  Scenario: We use closure implicit calling to define a rescue.
    Given the following source:
    """
    result = nil

    Exception = Huia.requireCore: 'exception'

    testClosure = Closure.create:
      @rescueFrom: Exception with: |exception|
        result = exception

      raiseException: Exception withMessage: 'Explode'

    testClosure.callWithSelf: self andArgs: []

    result
    """
    When it is evaluated
    Then the result includes '<Object(Exception)#'
    And the result includes 'Explode'

  Scenario: We use closure implicit calling to rescue a call further up the stack.
    Given the following source:
    """
    result = nil
    Exception = Huia.requireCore: 'exception'

    TestClass = Object.extend:
      def: 'methodOne' as:
        @rescueFrom: Exception with: |exception|
          result = exception

        self.methodTwo

      def: 'methodTwo' as:
        raiseException: Exception withMessage: 'Explode'

    TestClass.create.methodOne

    result
    """
    When it is evaluated
    Then the result includes '<Object(Exception)#'
    And the result includes 'Explode'

  Scenario: We can rescue subclasses of Exception.
    Given the following source:
    """
    result = nil
    Exception = Huia.requireCore: 'exception'
    TestException = Exception.extend:
      set: 'name' to: 'TestException'

    TestClass = Object.extend:
      def: 'methodOne' as:
        @rescueFrom: TestException with: |exception|
          result = exception

        raiseException: TestException withMessage: 'Explode'

    TestClass.create.methodOne

    result
    """
    When it is evaluated
    Then the result includes '<Object(TestException)#'
    And the result includes 'Explode'
