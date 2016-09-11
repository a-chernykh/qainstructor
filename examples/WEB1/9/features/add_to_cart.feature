Feature: Shopping cart

  Scenario: Add cucumbers to the shopping cart
    Given my shopping cart is empty
    When I add "Cucumbers" to the shopping cart
    Then I should have "Cucumbers" inside my shopping cart
