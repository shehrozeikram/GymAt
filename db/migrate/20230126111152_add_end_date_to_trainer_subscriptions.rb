class AddEndDateToTrainerSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :trainer_subscriptions, :end_date, :date
  end
end
