class AddOrderCounterToResturantDishes < ActiveRecord::Migration[6.1]
  def change
    add_column :resturant_dishes, :order_counter, :integer
  end
end
