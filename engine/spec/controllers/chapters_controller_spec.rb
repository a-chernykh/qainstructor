RSpec.describe ChaptersController do
  let(:user) { create :user }
  let(:course) { create :course }
  let(:chapter) { create :chapter, course: course, position: 1 }

  before { allow(controller).to receive(:authorize).with(chapter, :show?) }
  before { login_user user }

  describe 'GET show' do
    let(:action) { get :show, course_id: course.id, id: chapter.id }

    it 'authorizes chapter' do
      create(:user_completion, user: user, completable: chapter)
      expect(controller).to receive(:authorize).with(chapter, :show?)
      action
    end

    context 'not started chapter' do
      it 'redirects to course' do
        expect(action).to redirect_to(course_path(course))
      end
    end

    context 'started chapter' do
      before { create :user_completion, user: user, completable: chapter }

      it 'sets @course instance variable' do
        action
        expect(assigns[:course]).to eq course
      end

      it 'sets @chapter instance variable' do
        action
        expect(assigns[:chapter]).to eq chapter
      end
    end
  end

  describe 'POST finish' do
    let(:action) { post :finish, course_id: course.id, id: chapter.id }

    context 'not started chapter' do
      it 'redirects to course' do
        expect(action).to redirect_to(course_path(course))
      end
    end

    context 'started chapter' do
      before { create :user_completion, user: user, completable: chapter }

      it 'finishes given chapter' do
        action
        expect(user.user_completions.completed.map(&:completable)).to include chapter
      end

      context 'when next chapter is available' do
        it 'redirects to it' do
          next_chapter = create :chapter, course: course, position: 2
          action
          expect(response).to redirect_to course_chapter_path(course, next_chapter)
        end
      end

      context 'for the last chapter' do
        it 'redirects to course summary' do
          action
          expect(response).to redirect_to course_path(course)
        end
      end
    end
  end
end
