class JobAssetUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/jobs/#{model.job.user.id}/#{model.job.token}/#{mounted_as}"
  end
end
