class CreateResturantDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :resturant_dishes do |t|
      t.string :title
      t.text :attachments
      t.float :price
      t.integer :resturant_id

      t.timestamps
    end
  end
end
