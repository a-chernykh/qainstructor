RSpec.describe OfflineRegistrationsController do
  describe 'POST create' do
    context 'when valid' do
      let(:attributes) { attributes_for(:offline_registration) }
      let(:action) { post(:create, offline_registration: attributes) }

      it 'creates OfflineRegistration' do
        expect { action }.to change{ OfflineRegistration.count }.by(1)
      end

      it 'sends email confirmation' do
        expect(NewOfflineRegistration).to receive(:perform_async).with(anything)
        action
      end

      it 'redirects to thanks page' do
        action
        expect(response).to redirect_to(thanks_offline_registrations_url)
      end
    end
  end
end
