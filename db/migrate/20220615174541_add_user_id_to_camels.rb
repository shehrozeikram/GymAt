class AddUserIdToCamels < ActiveRecord::Migration[6.1]
  def change
    add_column :camels, :user_id, :integer
  end
end
