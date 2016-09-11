Feature: Sign in

  Scenario: User signs in
    Given I am on the Google front page
    When I click "Sign in" link
    Then I should be on the sign in page
