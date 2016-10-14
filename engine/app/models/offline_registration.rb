class OfflineRegistration < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
