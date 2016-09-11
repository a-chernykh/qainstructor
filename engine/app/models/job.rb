class Job < ActiveRecord::Base
  has_secure_token

  serialize :files, JSON
  serialize :meta, JSON

  enum language: { cucumber: 0 }
  enum status:   { created: 0, running: 1, finished: 2 }
  enum result:   { undefined: 0, success: 1, failure: 2 }

  has_many :job_assets, dependent: :destroy
  belongs_to :user

  validates :token, uniqueness: true
  validates :language, presence: true
  validates :status, presence: true
  validates :files, presence: true
  validates :user_id, presence: true
end
