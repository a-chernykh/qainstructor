Feature: Show message

Scenario: User clicks the button
  Given I am on the front page
  When I click on "Click me" button
  Then I should see "It works!" message
