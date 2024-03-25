FactoryBot.define do
    factory :user do
        first_name { "test client" }
        last_name { "test client" }
        email { Faker::Internet.email }
        password { "password123" }
        role { "client" }
        phone_number { "1234567890" }
        from { "new" }
    end
end