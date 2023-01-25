class CreateTrainerSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :trainer_subscriptions do |t|
      t.date :date
      t.time :time
      t.integer :trainer_id

      t.timestamps
    end
  end
end
