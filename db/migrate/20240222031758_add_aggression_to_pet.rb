class AddAggressionToPet < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :aggression, :string
  end
end
