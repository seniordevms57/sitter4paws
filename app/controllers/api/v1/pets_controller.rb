class Api::V1::PetsController < ApplicationController
    def create
        @pet = @user.pets.build(pet_params)
  
        if @pet.save
          render json: @pet, status: :created
        else
          render json: @pet.errors, status: :unprocessable_entity
        end
    end

    private

    def pet_params
        params.require(:pet).permit(:name, :pet_type, :breed, :color, :birthday, :gender, :aggression)
    end

    def set_user
        @user = current_user
    end    
end
