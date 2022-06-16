class AddBidTypeToCamels < ActiveRecord::Migration[6.1]
  def change
    add_column :camels, :bid_type, :string
  end
end
