class PetSerializer < ActiveModel::Serializer
    attributes :id, :name, :pet_type, :breed, :color, :birthday, :gender, :aggression, :created_at, :updated_at
  
    belongs_to :user
end
