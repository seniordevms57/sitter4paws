require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:jwt_token) { JWT.encode({ user_id: user.id, exp: Time.now.to_i + ENV['JWT_TOKEN_EXPIRATION_TIME'].to_i }, ENV['JWT_SECRET_KEY_BASE'], 'HS256') }

  describe "GET #index" do
    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        get :index
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns all users" do
        expect(JSON.parse(response.body)["users"].size).to eq(User.where.not(role: 'admin').count)
      end
    end

    context "when user is not authenticated" do
      before do
        get :index
      end

      it "returns an unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #show" do
    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        get :show, params: { id: user.id }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the user" do
        expect(JSON.parse(response.body)["user"]["id"]).to eq(user.id)
      end
    end

    context "when user is not authenticated" do
      before do
        get :show, params: { id: user.id }
      end

      it "returns an unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        post :create, params: {
          "client": {
            "first_name": "test",
            "last_name": "test",
            "email": "unittest@test.com",
            "password": "password123",
            "phone_number": "564651321",
            "role": "client",
            "from": "new"
          },
          "emergency": {
            "fullname": "test",
            "phone_number": "342432432",
            "vet_fullname": "test",
            "vet_phone_number": "4234242343"
          },
          "pets": [
            {
              "name": "test",
              "pet_type": "dog",
              "breed": "test",
              "color": "test"
            }
          ],
          "service": {
            "service": "test",
            "datetime": "test"
          }
        }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the created user" do
        expect(JSON.parse(response.body)["user"]["first_name"]).to eq('test')
      end
    end

    context "when user is authenticated with invalid params" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        post :create, params: {
          "client": {
            "first_name": "test",
            "last_name": "test",
            "email": "admin@test.com",
            "password": "password123",
            "phone_number": "564651321",
            "role": "client",
            "from": "new"
          },
          "emergency": {
            "fullname": "test",
            "phone_number": "342432432",
            "vet_fullname": "test",
            "vet_phone_number": "4234242343"
          },
          "pets": [
            {
              "name": "test",
              "pet_type": "dog",
              "breed": "test",
              "color": "test"
            }
          ],
          "service": {
            "service": "test",
            "datetime": "test"
          }
        }
      end

      it "Invalid params with existed email" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user is not authenticated" do
      before do
        delete :destroy, params: { id: user.id }
      end

      it "returns an unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT #update" do
    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        put :update, params: { id: user.id, client: { first_name: 'updated name' } }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the updated user" do
        expect(User.find_by(id: user.id).first_name).to eq('updated name')
      end
    end

    context "when user is not authenticated" do
      before do
        delete :destroy, params: { id: user.id }
      end

      it "returns an unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        delete :destroy, params: { id: user.id }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns all users except deteled user" do
        expect(User.find_by(id: user.id)).to be_nil
      end
    end

    context "when user is not authenticated" do
      before do
        delete :destroy, params: { id: user.id }
      end

      it "returns an unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end