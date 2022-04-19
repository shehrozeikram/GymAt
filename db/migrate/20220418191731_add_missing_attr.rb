class AddMissingAttr < ActiveRecord::Migration[6.1]
  def change
    add_column :user_time_slots, :time_slot_id, :integer
    add_column :user_time_slots, :appointment_id, :integer
    add_column :user_time_slots, :service_provider_id, :integer

    #
    add_column :appointments, :client_id, :integer
    add_column :services, :service_id, :integer

    add_column :service_availabilities, :day, :string
    add_column :service_availabilities, :start_time, :time
    add_column :service_availabilities, :end_time, :time
    add_column :service_availabilities, :service_provider_id, :integer

  end
end

