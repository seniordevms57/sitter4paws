class Pet < ApplicationRecord
    validates :name, presence: true
    validates :pet_type, presence: true
    validates :breed, presence: true
    validates :color, presence: true

    belongs_to :user
end
