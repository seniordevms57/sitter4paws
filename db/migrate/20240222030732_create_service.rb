class CreateService < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :service
      t.string :datetime
      t.string :discount_code
      t.string :comments
      t.string :signature
      t.string :heard_about_us
      t.boolean :wants_virtual_consultation
      t.integer :user_id

      t.timestamps
    end
  end
end
