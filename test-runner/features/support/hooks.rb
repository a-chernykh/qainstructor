Before do
  if ENV['SELENIUM_URL'] && !ENV['SELENIUM_URL'].empty? && ENV['SELENIUM_SESSION_ID'] && !ENV['SELENIUM_SESSION_ID'].empty?
    @browser = Selenium::WebDriver.for :remote, url: ENV['SELENIUM_URL'], session_id: ENV['SELENIUM_SESSION_ID']
    @browser.get('about:blank') # needed to reset the state because we're re-using existing browser sessions
  end
end

After do |scenario|
end
