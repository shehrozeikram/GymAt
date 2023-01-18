class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :title
      t.float :price
      t.string :description
      t.text :attachments
      t.string :shop_type
      t.integer :user_id
      t.integer :quantity

      t.timestamps
    end
  end
end
