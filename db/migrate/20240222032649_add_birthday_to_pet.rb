class AddBirthdayToPet < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :birthday, :datetime
  end
end
