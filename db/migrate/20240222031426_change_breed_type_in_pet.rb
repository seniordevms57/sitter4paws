class ChangeBreedTypeInPet < ActiveRecord::Migration[7.0]
  def change
    change_column :pets, :breed, :string
  end
end
