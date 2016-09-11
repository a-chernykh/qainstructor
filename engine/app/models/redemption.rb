class Redemption < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon

  validates :user_id, presence: true, uniqueness: { scope: :coupon_id, message: 'has already redeemed this coupon' }
  validates :coupon_id, presence: true
  validates :redeemed_at, presence: true

  def course
    coupon.course
  end
end
