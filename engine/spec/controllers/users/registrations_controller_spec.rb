module Users
  RSpec.describe RegistrationsController do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      request.env['HTTPS'] = 'on'
    end

    describe 'POST create' do
      def action
        params = {
          first_name: 'Andrey',
          last_name: 'Chernih',
          email: 'andrey@qainstructor.com',
          password: 'Testing1',
          password_confirmation: 'Testing1',
          terms_of_service: '1'
        }
        post(:create, user: params)
      end

      it 'creates user' do
        expect { action }.to change(User, :count).by(1)
      end

      it 'enqueues UserRegistered' do
        expect(UserRegistered).to receive(:perform_async).with(kind_of(Numeric))
        action
      end

      it 'does not enqueue UserRegistered when validation failed' do
        expect(UserRegistered).not_to receive(:perform_async)
        post(:create, user: {})
      end
    end
  end
end
