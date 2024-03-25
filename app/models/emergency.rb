class Emergency < ApplicationRecord
    validates :fullname, presence: true
    validates :phone_number, presence: true
    validates :vet_phone_number, presence: true
    validates :vet_fullname, presence: true

    belongs_to :user
end
