Feature: Ruby methods

  Scenario: 'unwrap' returns the native Ruby object
    Given the following source:
    """
    Ruby.createFromObject: 123
    .unwrap
    """
    When it is evaluated
    Then the result is not a Huia object

  Scenario: 'toString' turns the result into a string
    Given the following source:
    """
    Ruby.createFromObject: 123
    .toString
    """
    When it is evaluated
    Then the result is '"123"'

  Scenario: 'toInteger' turns the result into an integer
    Given the following source:
    """
    Ruby.createFromObject: 123
    .toInteger
    """
    When it is evaluated
    Then the result is '123'

  Scenario: 'toFloat' turns the result into a float
    Given the following source:
    """
    Ruby.createFromObject: 123
    .toFloat
    """
    When it is evaluated
    Then the result is '123.0'

  Scenario: 'toArray' turns the result into an array
    Given the following source:
    """
    Ruby.createFromObject: [1,2,3]
    .toArray
    """
    When it is evaluated
    Then the result is '[ 1, 2, 3 ]'

  Scenario: 'toHash' turns the result into a hash
    Given the following source:
    """
    Ruby.createFromObject: {1:2, 2:3}
    .toHash
    """
    When it is evaluated
    Then the result is '{ 1 : 2, 2 : 3 }'

  Scenario Outline: 'toBoolean' turns the result into a boolean
    Given the following source:
    """
    Ruby.createFromObject: <object>
    .toBoolean
    """
    When it is evaluated
    Then the result is '<result>'
    Examples:
      | object | result |
      | true   | true   |
      | Object | true   |
      | false  | false  |
      | nil    | false  |
