class Exercise < ActiveRecord::Base
  belongs_to :chapter

  validates :chapter_id, presence: true
  validates :position, presence: true, numericality: true, uniqueness: { scope: :chapter_id }
  validates :content, presence: true
end
