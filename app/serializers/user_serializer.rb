class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :role, :phone_number, :address, :confirmed_at, :add_someone, :phone_optin, :phone_updates_consent_text, :spouse_othername, :from, :created_at, :updated_at

  has_many :pets
  has_many :emergencys
  has_many :services
end
