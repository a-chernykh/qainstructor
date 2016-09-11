RSpec.describe CheatsheetsController do
  let!(:cheatsheet) { create(:cheatsheet, course: course, code: 'cheatsheet') }
  let(:course) { create(:course, code: 'WEB1') }
  let(:user) { create(:user) }

  describe 'GET show' do
    it 'redirects for unauthenticated user' do
      get(:show, course_id: course.id, code: 'cheatsheet')

      expect(response).to be_a_redirect
    end

    it 'redirects when course is not purchased' do
      login_user(user)

      get(:show, course_id: course.id, code: 'cheatsheet')

      expect(response).to be_a_redirect
    end

    it 'renders cheatsheet' do
      login_user(user)
      create(:user_course, user: user, course: course)

      get(:show, course_id: course.id, code: 'cheatsheet')

      expect(response).to render_template('cheatsheets/web1/cheatsheet')
    end
  end
end
