RSpec.describe UserRegistered do
  let(:user) { create(:user) }

  describe '#perform' do
    context 'when TRIAL10 coupon exists' do
      it 'sends promotional email' do
        course = create(:course)
        create(:coupon, course: course, code: 'TRIAL10')
        expect(PromotionsMailer).to receive(:trial_coupon_email).and_call_original
        described_class.perform_async(user.id)
      end
    end

    context 'when TRIAL10 coupon does not exist' do
      it 'does not send promotional email' do
        expect(PromotionsMailer).not_to receive(:trial_coupon_email)
        described_class.perform_async(user.id)
      end
    end
  end
end
