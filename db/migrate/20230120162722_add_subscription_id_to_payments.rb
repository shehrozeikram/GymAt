class AddSubscriptionIdToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :subscription_id, :integer
  end
end
