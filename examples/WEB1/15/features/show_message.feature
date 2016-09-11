Feature: Show secret message

  Scenario: User sees secret message
    Given I am on the front page
    When I click "Show message" link
    Then I should see "Secret message"
