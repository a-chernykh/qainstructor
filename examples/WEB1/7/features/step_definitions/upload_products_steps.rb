require 'singleton'

class Store
  include Singleton

  def products
    @products ||= []
  end

  def stock
    products.map { |p| p['quantity'].to_i }.inject(:+)
  end
end

Given(/^I am website administrator$/) do
end

When(/^I upload the following products:$/) do |products_table|
  products = products_table.hashes # [{"name"=>"apple", "price"=>"0.99", "quantity"=>"100"},
                                   #  {"name"=>"bananas", "price"=>"1.99", "quantity"=>"200"},
                                   #  {"name"=>"pears", "price"=>"1.49", "quantity"=>"150"}]
  products.each do |product|
    Store.instance.products << product
  end
end

Then(/^I should have (\d+) products in stock$/) do |expected_stock|
  expect(Store.instance.stock).to eq expected_stock.to_i
end
