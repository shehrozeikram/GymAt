# == Schema Information
#
# Table name: services
#
#  id                  :bigint           not null, primary key
#  ar_description      :string
#  ar_title            :string
#  attachments         :text
#  description         :text
#  ratings             :float
#  title               :string
#  type                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_id          :integer
#  service_provider_id :bigint           indexed
#  user_id             :integer
#
# Indexes
#
#  index_services_on_service_provider_id  (service_provider_id)
#
class Service < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  acts_as_taggable_on :tags
  acts_as_taggable_on :service_types
  belongs_to :service_provider, :class_name => "User"
  has_many :appointment

  def self.available_days(provider_id)
    days = ServiceAvailability.availability_days(provider_id)
    available_slots = (Date.today..Date.today.next_month).select {""}.map!{|f|
      [f.strftime("%A"), f.strftime("%A %F")]}.map{|k,v| k.in?(days) ? v : ""}.reject(&:blank?)
    available_slots
  end

  def self.time_slot(service_provider_id, day)

    service_availability = ServiceAvailability.where( service_provider_id: service_provider_id, day: day.split(/\W+/).first.capitalize).last
    total_minutes = (service_availability.end_time.strftime('%R').to_time - service_availability.start_time.strftime('%R').to_time) / 60
    time_slots = []
    Rails.logger.info " ti####################{total_minutes}#########################"
    (0..total_minutes).step(30) do |minutes|
      Rails.logger.info " ----------------------------------------------"

      time = service_availability.start_time.strftime('%R').to_time + minutes*60
      Rails.logger.info " time slot time slots#{time.strftime('%H:%M %p')}"

      time_slots << time.strftime('%H:%M %p')
    end
    time_slots
  end
end
