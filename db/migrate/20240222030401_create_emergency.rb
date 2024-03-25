class CreateEmergency < ActiveRecord::Migration[7.0]
  def change
    create_table :emergencies do |t|
      t.string :fullname
      t.string :phone_number
      t.string :vet_fullname
      t.string :vet_phone_number
      t.string :vet_street
      t.string :vet_apt_unit
      t.string :vet_city
      t.string :vet_state
      t.string :vet_zip
      t.integer :user_id

      t.timestamps
    end
  end
end
