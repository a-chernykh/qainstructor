Feature: Registration

  Scenario: User creates new account
    Given I am on the front page
    When I click "Register" button
    Then I should be on the registration page
