# == Schema Information
#
# Table name: appointments
#
#  id                  :bigint           not null, primary key
#  appointment_date    :datetime
#  day_slot            :string
#  time_slot           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  client_id           :integer
#  service_id          :integer
#  service_provider_id :bigint           indexed
#  user_id             :bigint           indexed
#
# Indexes
#
#  index_appointments_on_service_provider_id  (service_provider_id)
#  index_appointments_on_user_id              (user_id)
#
class Appointment < ApplicationRecord
  has_many   :user_time_slots
  belongs_to :client, :class_name => "User"
  belongs_to :service_provider, :class_name => "User"
  belongs_to :service
end
