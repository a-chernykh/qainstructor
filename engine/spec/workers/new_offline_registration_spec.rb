RSpec.describe NewOfflineRegistration do
  describe '#perform' do
    let(:registration) { create(:offline_registration) }

    it 'sends email confirmation' do
      expect(UserMailer).to receive(:offline_registration_confirmation).with(id: registration.id).and_call_original
      described_class.new.perform(registration.id)
    end
  end
end
