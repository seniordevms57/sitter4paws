class ApplicationController < ActionController::API
    before_action :authorized

    def jwt_key
        ENV['JWT_SECRET_KEY_BASE']
    end

    def issue_token(user)
        expiration_time = Time.now.to_i + ENV['JWT_TOKEN_EXPIRATION_TIME'].to_i
        payload = { user_id: user.id, exp: expiration_time }

        JWT.encode(payload, jwt_key, 'HS256')
    end

    def decoded_token
        begin
            JWT.decode(token, jwt_key, true, { :algorithm => 'HS256' })
        rescue JWT::DecodeError
            [{error: "Invalid Token"}]
        end
    end

    def authorized
        render json: { message: 'Not Authenticated', success: false }, status: :unauthorized unless logged_in?
    end

    def token
        request.headers['Authorization'].split(' ').last if request.headers['Authorization']
    end

    def user_id
        decoded_token.first['user_id']
    end

    def current_user
        @user ||= User.find_by(id: user_id)
    end

    def logged_in?
        !!current_user
    end
end
