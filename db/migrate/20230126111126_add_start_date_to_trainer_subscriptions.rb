class AddStartDateToTrainerSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :trainer_subscriptions, :start_date, :date
  end
end
