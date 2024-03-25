class ServiceArea < ApplicationRecord
    validates :name, presence: true
    validates :towns, presence: true
    validates :zip_codes, presence: true

    belongs_to :user
end
