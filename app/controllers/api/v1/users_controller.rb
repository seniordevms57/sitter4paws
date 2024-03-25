class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def index
        if params[:search].nil?
            users = User.where.not(role: 'admin')
        else
            search = params[:search]
            users = User.where.not(role: 'admin').where("first_name LIKE :text OR last_name LIKE :text OR email LIKE :text OR address LIKE :text OR phone_number LIKE :text", text: "%#{search}%")
        end

        serializer = ActiveModelSerializers::SerializableResource.new(users, each_serializer: UserSerializer)
        render json: { success: true, users: serializer.as_json }, status: :ok
    end

    def show
        @user = User.find(params[:id])

        render json: {user: UserSerializer.new(current_user)}
    end
 
    def create
        @user = User.new(user_params)
        success = true
        error = []

        if @user.valid?
            @user.save

            UserMailer.verify_email(@user).deliver_now

            zip_code = @user.address.split(", ")[@user.from === 'new' ? 4 : 1]
            service_area = ServiceArea.where("zip_codes LIKE ?", "%#{zip_code}%")
            if service_area.count > 0
                ServiceMailer.service_email(service_area[0].user).deliver_now
            else
                ServiceMailer.service_email(nil).deliver_now
            end

            if user_params[:from] === 'new'
                emergency = @user.emergencys.build(emergency_params)
                unless emergency.save
                    success = false
                    error << emergency.errors.full_messages.join(', ')
                end
            end

            service = @user.services.build(service_params)
            unless service.save
                success = false
                error << service.errors.full_messages.join(', ')
            end

            params["pets"].each do |el|
                pet_params = { name: el["name"], pet_type: el["pet_type"], breed: el["breed"], color: el["color"], birthday: el["birthday"], gender: el["gender"], aggression: el["aggression"] }                
                pet = @user.pets.build(pet_params)

                unless pet.save
                    success = false
                    error << pet.errors.full_messages.join(', ')
                end
            end

            render json: { user: UserSerializer.new(@user), success: success, error: error }
        else
            render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            render json: { user: UserSerializer.new(@user), success: true }, status: :ok
        else
            render json: { success: false, errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        begin
            @user = User.find(params[:id])
            @user.destroy

            render json: { success: true, error: '' }
        rescue => e
            render json: { success: false, error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end

    def verify
        @user = User.find_by(verification_token: params[:token])

        if @user
            @user.update(confirmed_at: Time.now)
            
            render json: { user: @user }
        else
            render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:client).permit(:first_name, :last_name, :email, :password, :role, :phone_number, :address, :add_someone, :phone_optin, :phone_updates_consent_text, :spouse_othername, :from)
    end

    def emergency_params
        params.require(:emergency).permit(:fullname, :phone_number, :vet_fullname, :vet_phone_number, :vet_street, :vet_apt_unit, :vet_city, :vet_state, :vet_zip)
    end

    def service_params
        params.require(:service).permit(:service, :datetime, :discount_code, :comments, :signature, :heard_about_us, :wants_virtual_consultation, :agree_policy)
    end
end
