Feature: Core Array methods

  Scenario: 'toString' converts the array to a string.
    Given the following source:
    """
    [1,2,3,4].toString
    """
    When it is evaluated
    Then the result is '"[ 1, 2, 3, 4 ]"'

  Scenario: 'at:' retrieves the value at the given index.
    Given the following source:
    """
    [1,2,3].at: 1
    """
    When it is evaluated
    Then the result is '2'

  Scenario: 'at:set:' sets teh value at the given index.
    Given the following source:
    """
    ary = [1,2,3]
    ary.at: 1 set: 6
    ary
    """
    When it is evaluated
    Then the result is '[ 1, 6, 3 ]'

  Scenario: 'push:' appends an element the end of the array.
    Given the following source:
    """
    ary = [1,1,2,3]
    ary.push: 5
    ary
    """
    When it is evaluated
    Then the result is '[ 1, 1, 2, 3, 5 ]'

  Scenario: 'size' returns the length of the array.
    Given the following source:
    """
    ary = [1,1,3,5,8]
    ary.size
    """
    When it is evaluated
    Then the result is '5'

  Scenario: 'inspect' shows the contents of the array.
    Given the following source:
    """
    [1,2,3,4].inspect
    """
    When it is evaluated
    Then the result is '"[ 1, 2, 3, 4 ]"'
