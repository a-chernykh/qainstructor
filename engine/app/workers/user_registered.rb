class UserRegistered
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)

    coupon = Coupon.where(code: 'TRIAL10').first
    if coupon
      PromotionsMailer.trial_coupon_email(user: user, coupon: coupon).deliver
    end
  end
end

