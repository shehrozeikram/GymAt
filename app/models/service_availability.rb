# == Schema Information
#
# Table name: service_availabilities
#
#  id         :bigint           not null, primary key
#  friday     :boolean
#  monday     :boolean
#  saturday   :boolean
#  sunday     :boolean
#  thursday   :boolean
#  tuesday    :boolean
#  wednesday  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  service_id :bigint           indexed
#
# Indexes
#
#  index_service_availabilities_on_service_id  (service_id)
#
class ServiceAvailability < ApplicationRecord
end
