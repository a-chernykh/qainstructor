Feature: Addition

  Scenario: Calculate sum of 2 variables
    Given I set variable A to 5
    And I set variable B to 4
    When I calculate A + B
    Then I should get result of 9
