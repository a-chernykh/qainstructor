When /^I add these numbers:$/ do |numbers_table|
  numbers = numbers_table.raw         # [["1"], ["5"], ["8"], ["3"]]
  numbers = numbers.flatten           # ["1", "5", "8", "3"]
  numbers = numbers.map(&:to_i)       # [1, 5, 8, 3]
  @result = numbers.inject(:+)        # 17
end

Then /^I should get result of (\d+)$/ do |expected_result|
  expect(@result).to eq expected_result.to_i
end
