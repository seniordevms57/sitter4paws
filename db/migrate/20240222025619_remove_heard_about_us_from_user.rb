class RemoveHeardAboutUsFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :heard_about_us, :string
  end
end
