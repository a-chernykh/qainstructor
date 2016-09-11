RSpec.describe Course do
  subject { build(:course) }

  it { is_expected.to define_enum_for(:level).with([:beginning, :intermediate, :advanced]) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:level) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:completion_time_hours) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
end
