class AddAgeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :float
  end
end
