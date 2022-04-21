class AddTimeSlotAndDaySlotToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :day_slot, :string
    add_column :appointments, :time_slot, :string
  end
end
