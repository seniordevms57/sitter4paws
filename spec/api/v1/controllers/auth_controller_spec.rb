require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:jwt_token) { JWT.encode({ user_id: user.id, exp: Time.now.to_i + ENV['JWT_TOKEN_EXPIRATION_TIME'].to_i }, ENV['JWT_SECRET_KEY_BASE'], 'HS256') }

  describe "GET #show" do
    context "Get current user" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        get :show
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns current user" do
        expect(JSON.parse(response.body)["id"]).to eq(user.id)
      end
    end
  end

  describe "POST #login" do
    context "Login successfully" do
      before do
        get :create, params: { user: { email: user.email, password: user.password } }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns JWT token" do
        expect(JSON.parse(response.body)["jwt"]).not_to be_empty
      end
    end
  end
end