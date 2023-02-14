class AddBusinessTypeToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :business_type, :string
  end
end
