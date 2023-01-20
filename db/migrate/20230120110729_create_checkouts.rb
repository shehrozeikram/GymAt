class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.string :title
      t.text :attachments
      t.boolean :free_delivery
      t.float :price
      t.integer :quantity
      t.float :sub_total
      t.string :shipping_fee
      t.float :discount
      t.float :total
      t.integer :user_id
      t.integer :shop_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
