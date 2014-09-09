Feature: Numeric methods

  Scenario Outline: `plus:` adds numbers together
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression | result |
      | 2.plus: 3  | 5      |
      | 3 + 4      | 7      |

  Scenario Outline: `minus:` subtracts numbers
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression | result |
      | 3.minus: 2 | 1      |
      | 7 - 4      | 3      |
      | 7 - 13     | -6     |

  Scenario Outline: `multiplyBy:` multiplies numbers
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression      | result |
      | 2.multiplyBy: 3 | 6      |
      | 4 * 7           | 28     |
      | 2 * 1           | 2      |
      | 13 * 0          | 0      |

  Scenario Outline: `divideBy:` divides numbers
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression    | result |
      | 6.divideBy: 3 | 2      |
      | 12 / 4        | 3      |
      | 4 / 1         | 4      |

  Scenario Outline: `toThePowerOf:` multiplies the number by itself
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression        | result |
      | 2.toThePowerOf: 4 | 16     |
      | 4 ** 4            | 256    |

  Scenario Outline: `moduloOf:` returns the remainder of a division
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression    | result |
      | 5.moduloOf: 2 | 1      |
      | 11 % 4        | 3      |

  Scenario Outline: `unaryPlus` returns the unary positive
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression    | result |
      | 5.unaryPlus   | 5      |
      | +5            | 5      |

  Scenario Outline: `unaryMinus` returns the unary positive
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression    | result |
      | 5.unaryMinus  | -5     |
      | -5            | -5     |

  Scenario: `inspect` converts the result to a string
    Given the following source "5.inspect"
    When it is evaluated
    Then the result is '"5"'

  Scenario: `toString` converts the result to a string
    Given the following source "5.toString"
    When it is evaluated
    Then the result is '"5"'
