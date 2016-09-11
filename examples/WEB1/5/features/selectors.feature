Feature: selenium-webdriver selectors

  Scenario: Verify selectors
    When I go to the front page
    Then I should find the following elements:
      | method            | selector                     | text               |
      | id                | test-element                 | Test               |
      | class_name        | item                         | Item 1 Item 2      |
      | tag_name          | header                       | Example header     |
      | name              | section-1                    | Section 1          |
      | link_text         | Sign In                      | Sign In            |
      | partial_link_text | account                      | Create new account |
      | css               | div.parent ul li:first-child | First              |
      | xpath             | //div/ul/li[1]               | First              |
