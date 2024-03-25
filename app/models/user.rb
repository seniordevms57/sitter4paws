class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :role, presence: true
    validates :phone_number, presence: true
    validates :from, presence: true

    has_many :pets
    has_many :emergencys
    has_many :services
    has_many :service_area

    has_secure_password
    before_create :generate_verification_token

    private

    def generate_verification_token
        self.verification_token = SecureRandom.urlsafe_base64
    end
end
