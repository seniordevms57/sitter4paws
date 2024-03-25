class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :type
      t.boolean :breed
      t.string :color
      t.string :birthday
      t.string :gender
      t.boolean :observations
      t.integer :user_id

      t.timestamps
    end
  end
end
