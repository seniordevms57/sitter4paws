class ServiceSerializer < ActiveModel::Serializer
    attributes :id, :service, :datetime, :discount_code, :comments, :signature, :heard_about_us, :wants_virtual_consultation, :agree_policy, :created_at, :updated_at
  
    belongs_to :user
end
