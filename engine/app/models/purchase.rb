class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user, presence: true
  validates :course, presence: true
  validates :charge_cents, presence: true, numericality: true
end
