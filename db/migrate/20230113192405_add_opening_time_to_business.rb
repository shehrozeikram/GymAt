class AddOpeningTimeToBusiness < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :opening_time, :string
  end
end
