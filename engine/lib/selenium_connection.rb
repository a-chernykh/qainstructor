class SeleniumConnection
  def initialize(url:)
    @url = url
    connect
  end

  def connect
    @browser = Selenium::WebDriver.for(:remote, url: @url)
  end

  def get
    begin
      @browser.current_url
    rescue Selenium::WebDriver::Error::UnknownError => e
      puts e.inspect
      connect
    end

    [@url, @browser.session_id]
  end
end
