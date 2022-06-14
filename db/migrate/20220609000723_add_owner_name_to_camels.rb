class AddOwnerNameToCamels < ActiveRecord::Migration[6.1]
  def change
    add_column :camels, :owner_name, :string
  end
end
