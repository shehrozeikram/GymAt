class CreateRelatedShops < ActiveRecord::Migration[6.1]
  def change
    create_table :related_shops do |t|
      t.string :title
      t.float :price
      t.string :description
      t.text :attachments
      t.string :shop_type
      t.integer :user_id
      t.integer :quantity
      t.integer :shop_id

      t.timestamps
    end
  end
end
