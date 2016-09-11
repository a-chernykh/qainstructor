class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :user_completions, dependent: :destroy
  has_many :chapters, through: :user_completions,
                      source: :completable,
                      source_type: 'Chapter'
  has_many :user_courses, dependent: :destroy
  has_many :purchased_courses, through: :user_courses, source: :course
  has_many :purchases, dependent: :destroy
  has_many :redemptions, dependent: :destroy
  has_many :coupons, through: :redemptions
  has_many :jobs, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :terms_of_service, acceptance: true

  def name
    [first_name, last_name].compact.join(' ')
  end

  protected

  def confirmation_required?
    false
  end
end
