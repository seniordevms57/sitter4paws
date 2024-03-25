class Service < ApplicationRecord
    validates :service, presence: true
    validates :datetime, presence: true

    belongs_to :user
end
