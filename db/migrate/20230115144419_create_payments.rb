class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :name_of_card
      t.string :card_number
      t.date :expiring_date
      t.string :cvc

      t.timestamps
    end
  end
end
