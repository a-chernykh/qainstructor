class PromotionsMailerPreview < ActionMailer::Preview
  def trial_coupon_email
    user = User.first
    coupon = Coupon.first

    PromotionsMailer.trial_coupon_email(user: user, coupon: coupon)
  end
end
