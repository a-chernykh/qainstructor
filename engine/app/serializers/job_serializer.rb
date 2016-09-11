class JobSerializer < ActiveModel::Serializer
  attributes :token, :status, :result
end
