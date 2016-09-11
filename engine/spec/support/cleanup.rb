RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf Rails.root.join('tmp/jobs/test')
  end
end
