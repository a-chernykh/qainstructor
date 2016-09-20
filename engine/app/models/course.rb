class Course < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :cheatsheets, dependent: :destroy
  has_many :purchases, dependent: :destroy

  enum level: { beginning: 0, intermediate: 1, advanced: 2 }

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :level, presence: true
  validates :description, presence: true
  validates :completion_time_hours, presence: true

  def self.web1
    @web1 ||= where(code: 'WEB1').first!
  end

  def cheatsheet
    cheatsheets.first
  end
end
