module Services

  class RedeemCoupon
    include Base

    def initialize(code:, user:)
      @code = code
      @user = user
    end

    def call
      coupon = Coupon.where(code: @code).first
      redemption = Redemption.new(coupon: coupon,
                                  user: @user,
                                  redeemed_at: Time.now.utc)

      if coupon
        if coupon.redemptions.count < coupon.redeem_limit
          if redemption.save
            if coupon.discount_percent == 100
              @user.purchased_courses << redemption.course
            end
          else
            errors.concat(redemption.errors.full_messages)
          end
        else
          errors << 'Coupon was already redeemed'
        end
      else
        errors << 'Coupon code was not found'
      end

      redemption
    end
  end

end
