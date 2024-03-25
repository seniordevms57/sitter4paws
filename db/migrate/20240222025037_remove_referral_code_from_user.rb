class RemoveReferralCodeFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :referral_code, :string
  end
end
