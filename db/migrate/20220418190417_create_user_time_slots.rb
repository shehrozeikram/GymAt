class CreateUserTimeSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :user_time_slots do |t|

      t.timestamps
    end
  end
end
