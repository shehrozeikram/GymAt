class AddRentPurposeToCamels < ActiveRecord::Migration[6.1]
  def change
    add_column :camels, :rent_purpose, :string
  end
end
