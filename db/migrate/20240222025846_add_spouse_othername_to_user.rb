class AddSpouseOthernameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :spouse_othername, :string
  end
end
