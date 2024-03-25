class AddfromToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :from, :string
  end
end
