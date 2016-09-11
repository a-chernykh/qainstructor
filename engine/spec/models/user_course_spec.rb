RSpec.describe UserCourse do
  subject { create(:user_course) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:course_id) }
  it { is_expected.to validate_uniqueness_of(:course_id).scoped_to(:user_id) }
end
