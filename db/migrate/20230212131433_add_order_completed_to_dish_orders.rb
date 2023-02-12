class AddOrderCompletedToDishOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :dish_orders, :order_completed, :boolean, default: false
  end
end
