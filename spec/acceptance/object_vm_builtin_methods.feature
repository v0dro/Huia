Feature: Object VM builtin methods

  Scenario: 'get:' retrieves instance variables
    Given the following source:
    """
    TestObject = Object.extend:

      def: 'test' as:
        set: 'testVariable' to: 'testValue'

        get: 'testVariable'

    TestObject.create.test
    """
    When it is evaluated
    Then the result is '"testValue"'

  Scenario: 'set:to:' can set and update instance variables
    Given the following source:
    """
    TestObject = Object.extend:

      def: 'test' as:
        result = []
        set: 'testVariable' to: 'testValue'

        result.push: (get: 'testVariable')

        set: 'testVariable' to: 'testValue2'

        result.push: (get: 'testVariable')
        result

    TestObject.create.test
    """
    When it is evaluated
    Then the result is:
    """
    [ "testValue", "testValue2" ]
    """

  Scenario: 'definePrivateMethod:as:' creates private methods on the receiver
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    TestObject = Object.extend:

      definePrivateMethod: 'exampleMethod' as:
        true

      defineMethod: 'privateMethods' as:
        result = []
        pmethods = get: 'privateMethods'
        ary = Ruby.createFromObject: pmethods
        .send: 'keys'
        .send: 'each' withBlock: |item|
          result.push: (String.createFromValue: item)

        result

    TestObject.privateMethods
    """
    When it is evaluated
    Then the result includes '"exampleMethod"'

  Scenario: 'defineMethod:as:' creates a new public method on the receiver.
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    TestObject = Object.extend:

      defineMethod: 'exampleMethod' as:
        true

      defineMethod: 'publicMethods' as:
        result = []
        methods = get: 'methods'
        ary = Ruby.createFromObject: methods
        .send: 'keys'
        .send: 'each' withBlock: |item|
          result.push: (String.createFromValue: item)

        result

    TestObject.publicMethods
    """
    When it is evaluated
    Then the result includes '"exampleMethod"'

  Scenario: 'undefinePrivateMethod:as:' removes private methods from the receiver
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    TestObject = Object.extend:

      definePrivateMethod: 'exampleMethod' as:
        true

      undefinePrivateMethod: 'exampleMethod'

      defineMethod: 'privateMethods' as:
        result = []
        pmethods = get: 'privateMethods'
        ary = Ruby.createFromObject: pmethods
        .send: 'keys'
        .send: 'each' withBlock: |item|
          result.push: (String.createFromValue: item)

        result

    TestObject.privateMethods
    """
    When it is evaluated
    Then the result doesn't include '"exampleMethod"'

  Scenario Outline: 'if:then:' has the correct truthy/falsy behaviour
    Given the following source:
    """
    TestObject = Object.extend:

      def: 'testMethod' as:
        result = false

        if: <testExpression> then:
          result = true

        result

    TestObject.create.testMethod
    """
    When it is evaluated
    Then the result is <resultValue>
    Examples:
      | testExpression | resultValue |
      | true           | true        |
      | Object         | true        |
      | Object.create  | true        |
      | 0              | true        |
      | "true"         | true        |
      | 15             | true        |
      | 1.5            | true        |
      | []             | true        |
      | {}             | true        |
      | false          | false       |
      | nil            | false       |

