RSpec.describe CourseOrder do
  let(:coupon25) { create(:coupon, course: course, discount_percent: 25) }
  let(:coupon80) { create(:coupon, course: course, discount_percent: 80) }
  let(:course) { create(:course, price_cents: 10000) }
  let(:user) { create(:user) }

  subject { described_class.new(course: course, user: user) }

  describe '#full_price' do
    it 'returns full course price' do
      expect(subject.full_price).to eq 10000
    end
  end

  describe '#adjusted_price' do
    it 'returns full price when users is not logged in' do
      order = described_class.new(course: course, user: nil)
      expect(order.adjusted_price).to eq 10000
    end

    it 'returns full price when no coupons applied' do
      expect(subject.adjusted_price).to eq 10000
    end

    it 'returns full price minus applied coupons' do
      create(:redemption, user: user, coupon: coupon25)
      expect(subject.adjusted_price).to eq 7500
    end

    it 'will not go past 0' do
      create(:redemption, user: user, coupon: coupon25)
      create(:redemption, user: user, coupon: coupon80)
      expect(subject.adjusted_price).to eq 0
    end

    it 'is integer' do
      create(:redemption, user: user, coupon: coupon25)
      expect(subject.adjusted_price).to be_a(Integer)
    end
  end

  describe '#discounted?' do
    it 'is true when adjusted_price < full_price' do
      create(:redemption, user: user, coupon: coupon25)
      expect(subject).to be_discounted
    end

    it 'is false when adjusted_price = full_price' do
      expect(subject).not_to be_discounted
    end
  end
end
