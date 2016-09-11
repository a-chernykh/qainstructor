Given(/^I am on the front page$/) do
  @browser.get('http://secret.app.lvh.me')
end

When(/^I click on "([^"]*)" button$/) do |button_name|
  button = @browser.find_element(:css, "input[value='#{button_name}']")
  button.click
end

Then(/^I should see "([^"]*)" message$/) do |message|
  body = @browser.find_element(:tag_name, 'body')
  expect(body.text).to include(message)
end
