Given(/^I set variable A to (\d+)$/) do |a|
  @a = a.to_i
end

Given(/^I set variable B to (\d+)$/) do |b|
  @b = b.to_i
end

When(/^I calculate A \+ B$/) do
  @result = @a + @b
end

Then(/^I should get result of (\d+)$/) do |expected_result|
  expect(@result).to eq expected_result.to_i
end
