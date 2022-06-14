class AddCamelPurposeToCamels < ActiveRecord::Migration[6.1]
  def change
    add_column :camels, :camel_purpose, :string
  end
end
