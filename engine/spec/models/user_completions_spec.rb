RSpec.describe UserCompletion do
  subject { create(:user_completion) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:completable_type) }
  it { is_expected.to validate_presence_of(:completable_id) }
  it { is_expected.to validate_inclusion_of(:completable_type).in_array %w(Chapter Exercise) }
  it { is_expected.to validate_presence_of(:started_at) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:completable_id, :completable_type) }
end
