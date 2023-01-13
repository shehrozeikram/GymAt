class AddCityToBusiness < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :city, :string
  end
end
