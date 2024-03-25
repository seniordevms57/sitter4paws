class RemoveBirthdayFromPet < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :birthday, :string
  end
end
