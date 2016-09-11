RSpec.describe JobAsset do
  it { is_expected.to validate_presence_of(:job_id) }
  it { is_expected.to validate_presence_of(:file) }
end
