Before do
  @browser = Selenium::WebDriver.for :firefox
  @browser.manage.timeouts.implicit_wait = 20 # seconds
end

After do |scenario|
  @browser.quit unless scenario.failed?
end
