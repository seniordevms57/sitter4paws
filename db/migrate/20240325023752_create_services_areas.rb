class CreateServicesAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :service_areas do |t|
      t.string :name
      t.string :towns
      t.string :zip_codes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
