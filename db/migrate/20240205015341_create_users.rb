class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :password_digest
      t.date :confirmed_at
      t.string :verification_token
      t.string :referral_code
      t.boolean :tos_accepted
      t.string :heard_about_us
      t.boolean :phone_optin
      t.boolean :phone_updates_consent_text
      t.boolean :wants_virtual_consultation

      t.timestamps
    end
  end
end
