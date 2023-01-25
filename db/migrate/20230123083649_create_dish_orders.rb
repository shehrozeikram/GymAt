class CreateDishOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :dish_orders do |t|
      t.boolean :self_pickup
      t.float :delivery
      t.float :discount
      t.integer :user_id
      t.integer :resturant_dish_id
      t.integer :payment_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
