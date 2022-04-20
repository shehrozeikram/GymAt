# == Schema Information
#
# Table name: user_time_slots
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  appointment_id      :integer
#  service_provider_id :integer
#  time_slot_id        :integer
#
class UserTimeSlot < ApplicationRecord
  belongs_to :time_slot
  belongs_to :service_provider, :class_name => "User"
  belongs_to :appointment
end
