require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

Before do
  @browser = Selenium::WebDriver.for(:firefox)
end
