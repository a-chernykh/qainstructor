class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, presence: true
  validates :course_id, presence: true, uniqueness: { scope: :user_id }
end
