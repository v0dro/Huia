Feature: Object methods

  Scenario Outline: 'if:then:else:' has the correct truthy/fasly behaviour
    Given the following source:
    """
    TestObject = Object.extend:

      def: 'testMethod' as:
        result = nil

        if: <testExpression> then:
          result = "then"
        else:
          result = "else"

        result

    TestObject.create.testMethod
    """
    When it is evaluated
    Then the result is <resultValue>
    Examples:
      | testExpression | resultValue |
      | true           | '"then"'    |
      | Object         | '"then"'    |
      | Object.create  | '"then"'    |
      | 0              | '"then"'    |
      | "true"         | '"then"'    |
      | 15             | '"then"'    |
      | 1.5            | '"then"'    |
      | []             | '"then"'    |
      | {}             | '"then"'    |
      | false          | '"else"'    |
      | nil            | '"else"'    |


  Scenario Outline: 'unless:then:' has the correct truthy/fasly behaviour
    Given the following source:
    """
    TestObject = Object.extend:

      def: 'testMethod' as:
        result = nil

        unless: <testExpression> then:
          result = "then"

        result

    TestObject.create.testMethod
    """
    When it is evaluated
    Then the result is <resultValue>
    Examples:
      | testExpression | resultValue |
      | true           | nil         |
      | Object         | nil         |
      | Object.create  | nil         |
      | 0              | nil         |
      | "true"         | nil         |
      | 15             | nil         |
      | 1.5            | nil         |
      | []             | nil         |
      | {}             | nil         |
      | false          | '"then"'    |
      | nil            | '"then"'    |


  Scenario: 'class' returns the object's class
    Given the following source:
    """
    Object.create.class
    """
    When it is evaluated
    Then the result includes "<Class(Object)#"

  Scenario Outline: 'respondsTo:' has the correct behaviour
    Given the following source:
    """
    TestObjectA = Object.extend:

      def: 'testMethodA' as:
        "A"

    TestObjectB = TestObjectA.extend:

      def: 'testMethodB' as:
        "B"

    TestObjectB.create.respondsTo: '<methodName>'
    """
    When it is evaluated
    Then the result is <result>
    Examples:
      | methodName  | result |
      | testMethodA | true   |
      | testMethodB | true   |
      | testMethodC | false  |

  Scenario Outline: 'unaryNot' returns false
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression             | result |
      | Object.unaryNot        | false  |
      | Object.create.unaryNot | false  |
      | !Object                | false  |
      | !Object.create         | false  |

  Scenario Outline: 'truthy?' returns true
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression            | result |
      | Object.truthy?        | true   |
      | Object.create.truthy? | true   |

  Scenario Outline: 'falsy?' returns '!truthy?'
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression           | result  |
      | Object.falsy?        | false   |
      | Object.create.falsy? | false   |

  Scenario Outline: 'isNotEqualTo:' returns '!isEqualTo:'
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression           | result  |
      | 1.isNotEqualTo: 1    | false   |
      | 1 != 1               | false   |

  Scenario: 'name' returns the class name
    Given the following source:
    """
    ExampleClass = Object.extend:
      set: 'name' to: 'ExampleClass'

    ExampleClass.name
    """
    When it is evaluated
    Then the result is '"ExampleClass"'
