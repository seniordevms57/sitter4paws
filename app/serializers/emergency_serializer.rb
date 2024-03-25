class EmergencySerializer < ActiveModel::Serializer
    attributes :id, :fullname, :phone_number, :vet_fullname, :vet_phone_number, :vet_street, :vet_apt_unit, :vet_city, :vet_state, :vet_zip, :created_at, :updated_at
  
    belongs_to :user
end
