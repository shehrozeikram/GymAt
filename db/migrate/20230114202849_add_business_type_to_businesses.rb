class AddBusinessTypeToBusinesses < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :business_type, :string
  end
end
