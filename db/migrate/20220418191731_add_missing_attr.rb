class AddMissingAttr < ActiveRecord::Migration[6.1]
  def change
    add_column :user_time_slots, :time_slot_id, :integer
    add_column :user_time_slots, :appointment_id, :integer
    add_column :user_time_slots, :service_provider_id, :integer

    #
    add_column :appointments, :client_id, :integer
    add_column :services, :service_id, :integer

    add_column :services, :day, :string
    add_column :services, :start_time, :time
    add_column :services, :end_time, :time
    add_column :services, :service_id, :integer
    add_column :services, :service_provider_id, :integer

  end
end

# class UserTimeSlot < ApplicationRecord
#   belongs_to :time_slot
#   belongs_to :service_provider, :class_name => "User"
#   belongs_to :appointment
# end

# class Appointment < ApplicationRecord
#   has_many   :user_time_slots
#   belongs_to :client, :class_name => "User"
#   belongs_to :service_provider, :class_name => "User"
#   belongs_to :service
# end