RSpec.describe CheatsheetPolicy do
  let(:user) { create(:user) }
  let(:course) { create(:course) }
  let(:cheatsheet) { create(:cheatsheet, course: course) }

  subject { described_class }

  permissions :show? do
    it 'denies access when user have not purchased course' do
      expect(subject).not_to permit(user, cheatsheet)
    end

    it 'grants access' do
      create(:user_course, user: user, course: course)

      expect(subject).to permit(user, cheatsheet)
    end
  end
end
