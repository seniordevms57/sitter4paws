class AddAgreePolicyToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :agree_policy, :boolean
  end
end
