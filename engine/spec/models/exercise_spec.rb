RSpec.describe Exercise do
  subject { build(:exercise) }

  it { is_expected.to validate_presence_of(:chapter_id) }
  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_numericality_of(:position) }
  it { is_expected.to validate_uniqueness_of(:position).scoped_to(:chapter_id) }
  it { is_expected.to validate_presence_of(:content) }
end
