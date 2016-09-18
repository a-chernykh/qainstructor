Split.configure do |config|
  config.ignore_ip_addresses << '76.102.13.120' # Andrey's Comcast

  config.bots['UptimeRobot'] = 'Uptime Robot'
  config.bots['XoviBot'] = 'XoviBot'
end
