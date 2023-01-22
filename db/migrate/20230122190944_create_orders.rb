class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.boolean :self_pickup
      t.float :delivery
      t.float :discount
      t.integer :user_id
      t.integer :resturant_dish_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
