class AddClosingTimeToBusiness < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :closing_time, :string
  end
end
