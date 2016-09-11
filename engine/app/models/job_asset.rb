class JobAsset < ActiveRecord::Base
  belongs_to :job

  validates :job_id, presence: true
  validates :file, presence: true

  mount_uploader :file, JobAssetUploader
end
