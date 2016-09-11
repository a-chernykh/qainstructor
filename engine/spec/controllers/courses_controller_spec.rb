RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:course) { create(:course) }

  before { request.env['HTTPS'] = 'on'}

  describe 'GET continue' do
    let!(:chapter) { create :chapter, course: course }
    let(:action) { get :continue, id: course.id }

    before { login_user(user) }
    before { user.purchased_courses << course }

    context 'when next chapter is available' do
      it 'starts it' do
        action
        expect(user.chapters).to include chapter
      end

      it 'redirects to it' do
        action
        expect(response).to redirect_to(course_chapter_path(course, chapter))
      end
    end

    context 'when user has finished course' do
      before { create :user_completion, :completed, user: user, completable: chapter }

      it 'redirects to course summary' do
        action
        expect(response).to redirect_to(course_path(course))
      end
    end
  end

  describe 'GET show' do
    let(:action) { get(:show, id: course.id) }

    context 'when user is authenticated' do
      before { login_user(user) }

      it 'creates CourseEngine' do
        action
        expect(controller.engine).to be_an_instance_of(CourseEngine)
      end
    end

    context 'when user is not authenticated' do
      it 'creates NullCourseEngine' do
        action
        expect(controller.engine).to be_an_instance_of(NullCourseEngine)
      end

      it 'renders show template' do
        action
        expect(response).to render_template('show')
      end
    end
  end

  describe 'GET toc' do
    let(:action) { get(:toc, id: course.id) }

    it 'assigns @toc' do
      action
      expect(assigns[:toc]).to be_an_instance_of(TableOfContents)
    end

    it 'assigns @course 'do
      action
      expect(assigns[:course]).to eq course
    end

    it 'renders toc.html.erb' do
      action
      expect(response).to render_template('courses/toc')
    end
  end

  describe 'GET purchased' do
    let(:action) { get(:purchased, id: course.id) }

    it 'renders purchased.html' do
      action
      expect(response).to render_template('courses/purchased')
    end
  end
end
