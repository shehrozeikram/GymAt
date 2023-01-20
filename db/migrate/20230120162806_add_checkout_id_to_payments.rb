class AddCheckoutIdToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :checkout_id, :integer
  end
end
