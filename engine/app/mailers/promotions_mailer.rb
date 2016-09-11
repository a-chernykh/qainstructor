class PromotionsMailer < ApplicationMailer
  def trial_coupon_email(user:, coupon:)
    @user = user
    @coupon = coupon
    @course = coupon.course

    mail(to: @user.email, subject: 'Your 50% discount coupon')
  end
end
