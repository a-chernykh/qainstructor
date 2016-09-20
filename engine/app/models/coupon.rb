class Coupon < ActiveRecord::Base
  belongs_to :course
  has_many :redemptions, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :course_id, presence: true
  validates :discount_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :discount_cents, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def name
    code
  end
end
