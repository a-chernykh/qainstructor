class JobAssetSerializer < ActiveModel::Serializer
  attributes :name, :url

  def name
    File.basename(object.file.path)
  end

  def url
    object.file.url
  end
end
