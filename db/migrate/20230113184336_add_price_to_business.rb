class AddPriceToBusiness < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :price, :integer
  end
end
