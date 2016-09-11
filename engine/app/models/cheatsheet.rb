class Cheatsheet < ActiveRecord::Base
  belongs_to :course

  validates :course_id, presence: true
  validates :code, presence: true, uniqueness: { scope: :course_id }

  def to_param
    code
  end
end
