class UserCompletion < ActiveRecord::Base
  belongs_to :user
  # Chapter or Exercise
  belongs_to :completable, polymorphic: true

  scope :completed, -> { where.not(completed_at: nil) }
  scope :started, -> { where.not(started_at: nil) }

  validates :user_id, presence: true, uniqueness: { scope: [:completable_type, :completable_id] }
  validates :completable_type, presence: true, inclusion: { in: %w(Chapter Exercise) }
  validates :completable_id, presence: true
  validates :started_at, presence: true
end
