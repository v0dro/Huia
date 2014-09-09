Feature: Integer methods

  Scenario Outline: `unaryComplement` returns the unary complement
    Given the following source "<expression>"
    When it is evaluated
    Then the result is <result>
    Examples:
      | expression        | result |
      | 5.unaryComplement | -6     |
      | ~5                | -6     |
