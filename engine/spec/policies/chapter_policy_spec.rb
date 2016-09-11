RSpec.describe ChapterPolicy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :show? do
    context 'user have not purchased course' do
      it 'grants access to demo chapters' do
        chapter = create(:chapter, is_demo: true)

        expect(subject).to permit(user, chapter)
      end

      it 'denies access to all other chapters' do
        chapter = create(:chapter, is_demo: false)

        expect(subject).not_to permit(user, chapter)
      end
    end

    context 'user purchased course' do
      it 'grants access to all chapters' do
        course = create(:course)
        create(:user_course, user: user, course: course)
        chapter = create(:chapter, course: course, is_demo: false)

        expect(subject).to permit(user, chapter)
      end
    end
  end
end
