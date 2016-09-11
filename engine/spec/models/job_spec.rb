RSpec.describe Job do
  subject { build :job }

  it { is_expected.to define_enum_for(:language).with([:cucumber]) }
  it { is_expected.to define_enum_for(:status).with([:created, :running, :finished]) }
  it { is_expected.to define_enum_for(:result).with([:undefined, :success, :failure]) }

  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:language) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:files) }
  it { is_expected.to validate_presence_of(:user_id) }
end
