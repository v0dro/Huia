Feature: Ruby building VM methods

  Scenario: 'Ruby.createFromConstant:' returns a wrapped version a constant from the surrounding Ruby environment.
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    class = Ruby.createFromConstant: 'Fixnum'
    .send: 'to_s'

    String.createFromValue: class
    """
    When it is evaluated
    Then the result is '"Fixnum"'

  Scenario: 'Ruby.createFromObject:' can wrap an arbitrary object from the surrounding Ruby environment.
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    i = Ruby.createFromObject: 1
    .send: 'to_s'

    String.createFromValue: i
    """
    When it is evaluated
    Then the result is '"1"'

  Scenario: 'send:withArgs:andBlock:' can call a Ruby method, passing arguments and a block.
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    obj = Ruby.createFromObject: [1,2,3]
    .send: 'inject' withArgs: [0] andBlock: |memo,i|
      memo = memo + i

    String.createFromValue: obj
    """
    When it is evaluated
    Then the result is '6'

  Scenario: 'send:withArgs:' can call a Ruby method, passing arguments.
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    two   = Ruby.createFromObject: 2
    three = Ruby.createFromObject: 3
    .unwrap

    five = two.send: '+' withArgs: [three]
    .send: 'to_s'

    String.createFromValue: five
    """
    When it is evaluated
    Then the result is '"5"'

  Scenario: 'send:withBlock:' can call a Ruby method, passing a block.
    Given the following source:
    """
    result = 'hello'

    Ruby.createFromObject: ['world']
    .send: 'each' withBlock: |item|
      result.push: " #{item}"

    result
    """
    When it is evaluated
    Then the result is '"hello world"'

  Scenario: 'send:' call call a Ruby method.
    Given the following source:
    """
    String = Huia.requireCore: 'string'

    str = Ruby.createFromObject: "hello"
    .send: 'reverse'

    String.createFromValue: str
    """
    When it is evaluated
    Then the result is '"olleh"'

  Scenario Outline: 'truthy?' returns a boolean
    Given the following source:
    """
    Ruby.createFromObject: <object>
    .truthy?
    """
    When it is evaluated
    Then the result is '<result>'
    Examples:
      | object  | result |
      | true    | true   |
      | "hello" | true   |
      | 0       | true   |
      | Object  | true   |
      | false   | false  |
      | nil     | false  |

  Scenario: 'inspect' returns useful information
    Given the following source:
    """
    Ruby.createFromObject: 123
    .inspect
    """
    When it is evaluated
    Then the result includes '<Class(Ruby)#'
    And the result includes 'object=123>'
