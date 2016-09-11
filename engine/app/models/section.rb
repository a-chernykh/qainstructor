class Section < ActiveRecord::Base
  belongs_to :course
  has_many :chapters, dependent: :destroy

  validates :course_id, presence: true
  validates :name, presence: true
  validates :position, presence: true, uniqueness: { scope: :course_id }

  scope :by_position, -> { order(:position) }
end
