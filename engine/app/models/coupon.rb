class Coupon < ActiveRecord::Base
  belongs_to :course
  has_many :redemptions, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :course_id, presence: true
  validates :discount_percent, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  def name
    code
  end
end
