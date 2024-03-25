class RemoveWantsVirtualConsultationFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :wants_virtual_consultation, :boolean
  end
end
