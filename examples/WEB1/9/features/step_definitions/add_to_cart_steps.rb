Given(/^my shopping cart is empty$/) do
  @shopping_cart = []
end

When(/^I add "([^"]*)" to the shopping cart$/) do |product|
  @shopping_cart << product
end
