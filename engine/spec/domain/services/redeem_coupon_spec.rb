module Services

  RSpec.describe RedeemCoupon do
    let(:user) { create(:user) }

    describe '#call' do
      it 'adds error when code does not exist' do
        service = described_class.new(code: 'non-existant', user: user)

        service.call

        expect(service).not_to be_valid
      end

      it 'adds error if coupon was already redeemed' do
        coupon = create(:coupon, code: 'my-coupon', redeem_limit: 1)
        create(:redemption, coupon: coupon)
        service = described_class.new(code: 'my-coupon', user: user)

        service.call

        expect(service).not_to be_valid
      end

      it 'creates new redemption' do
        coupon = create(:coupon, code: 'my-coupon')
        service = described_class.new(code: 'my-coupon', user: user)

        service.call

        expect(coupon.redemptions.where(user: user).count).to eq 1
      end

      it 'creates new purchase if discount is 100%' do
        coupon = create(:coupon, code: 'my-coupon', discount_percent: 100)
        service = described_class.new(code: 'my-coupon', user: user)

        service.call

        expect(user.purchased_courses).to include(coupon.course)
      end
    end
  end

end
