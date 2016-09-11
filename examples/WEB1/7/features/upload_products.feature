Feature: Upload products

  Scenario: Administrator uploads products
    Given I am website administrator
    When I upload the following products:
      | name     | price | quantity |
      | apple    | 0.99  | 100      |
      | bananas  | 1.99  | 200      |
      | pears    | 1.49  | 150      |
    Then I should have 450 products in stock
