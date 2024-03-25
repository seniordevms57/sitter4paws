class RenameTosAcceptedFromUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :tos_accepted, :add_someone
  end
end
