Before do
  @browser = Selenium::WebDriver.for :firefox
end

After do |scenario|
  @browser.quit unless scenario.failed?
end
