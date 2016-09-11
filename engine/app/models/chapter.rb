class Chapter < ActiveRecord::Base
  enum content_type: { text: 0, exercise: 1 }

  belongs_to :course
  belongs_to :section
  has_many :exercises, dependent: :destroy
  has_many :user_completions, as: :completable, dependent: :destroy
  has_many :users, through: :user_completions

  validates :name, presence: true
  validates :description, presence: true
  validates :position, presence: true, numericality: true, uniqueness: { scope: :course_id }
  validates :course_id, presence: true
  validates :section_id, presence: true

  scope :by_position, -> { order(:position) }
  scope :started_by, -> (user) {
    joins(:user_completions)
      .where('user_completions.user_id' => user.id)
      .merge(UserCompletion.started)
  }
  scope :demo, -> { where(is_demo: true) }

  def content_path
    File.join(course.code.downcase, section.code.downcase, code)
  end

  def previous
    @previous ||= course.chapters
      .where('position < ?', position)
      .order(position: :desc)
      .first
  end

  def next
    @next ||= course.chapters
      .where('position > ?', position)
      .order(position: :asc)
      .first
  end
end
