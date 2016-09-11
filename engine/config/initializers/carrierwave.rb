CarrierWave.configure do |config|
  config.storage = Rails.env.test? ? :file : :fog

  unless Rails.env.test?
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'us-west-1',
    }
    config.fog_directory  = "qa-engine-#{Rails.env}"
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
end
