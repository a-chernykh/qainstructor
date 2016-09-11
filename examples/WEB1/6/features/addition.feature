Feature: Addition

  Scenario: Add numbers together
    When I add these numbers:
      | 1 |
      | 5 |
      | 8 |
      | 3 |
    Then I should get result of 17
