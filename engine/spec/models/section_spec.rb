RSpec.describe Section do
  subject { build(:section) }

  it { is_expected.to validate_presence_of(:course_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_uniqueness_of(:position).scoped_to(:course_id) }
end
