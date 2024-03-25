class RenameTypeFromPet < ActiveRecord::Migration[7.0]
  def change
    rename_column :pets, :type, :pet_type
  end
end
