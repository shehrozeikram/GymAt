# == Schema Information
#
# Table name: service_availabilities
#
#  id                  :bigint           not null, primary key
#  day                 :string
#  end_time            :time
#  start_time          :time
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_id          :integer
#  service_provider_id :integer
#
class ServiceAvailability < ApplicationRecord
  belongs_to :service_provider, :class_name => "User"
  scope :availability_days, ->   (service_provider_id){ where(service_provider_id: service_provider_id).collect(&:day).map{|d| d.capitalize} }

end
