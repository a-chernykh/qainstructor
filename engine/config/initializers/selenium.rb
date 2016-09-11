$selenium = ConnectionPool.new(size: 3, timeout: 5) { SeleniumConnection.new(url: "http://selenium-server:4444/wd/hub") }
