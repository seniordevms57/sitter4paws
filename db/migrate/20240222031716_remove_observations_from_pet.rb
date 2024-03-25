class RemoveObservationsFromPet < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :observations, :boolean
  end
end
