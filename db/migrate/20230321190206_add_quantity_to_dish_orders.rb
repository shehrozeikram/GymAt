class AddQuantityToDishOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :dish_orders, :quantity, :integer
  end
end
