RSpec.describe Redemption do
  subject { create(:redemption) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:coupon_id) }
  it { is_expected.to validate_presence_of(:redeemed_at) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:coupon_id).with_message(/already redeemed/) }

  describe '#course' do
    it 'returns coupon course' do
      expect(subject.course).to eq subject.coupon.course
    end
  end
end
