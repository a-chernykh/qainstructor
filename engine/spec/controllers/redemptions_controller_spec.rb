RSpec.describe RedemptionsController do
  let(:user) { create(:user) }

  before { request.env['HTTPS'] = 'on' }

  describe 'GET new' do
    it 'requires user to login' do
      get(:new)

      expect(response).to be_a_redirect
    end

    it 'renders redemption form' do
      login_user(user)

      get(:new)

      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    it 'requires user to login' do
      post(:create)

      expect(response).to be_a_redirect
    end

    it 'renders form if invalid' do
      login_user(user)

      post(:create, coupon: 'invalid')

      expect(response).to render_template(:new)
    end

    it 'redeems coupon' do
      login_user(user)
      create(:coupon, code: 'my-coupon')

      expect { post(:create, coupon: 'my-coupon') }.to change(Redemption, :count).by(1)
    end

    it 'redirects to course page' do
      login_user(user)
      coupon = create(:coupon, code: 'my-coupon')

      post(:create, coupon: 'my-coupon')

      expect(response).to redirect_to(course_path(coupon.course))
    end
  end
end
