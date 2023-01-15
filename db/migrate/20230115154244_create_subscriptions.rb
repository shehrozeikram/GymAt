class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :full_name
      t.date :start_date
      t.string :subscription_type
      t.string :amount
      t.string :discount
      t.string :special_offer
      t.string :total_amount
      t.integer :payment_id
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
