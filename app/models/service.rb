# == Schema Information
#
# Table name: services
#
#  id                  :bigint           not null, primary key
#  ar_description      :string
#  ar_title            :string
#  description         :text
#  ratings             :float
#  title               :string
#  type                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_provider_id :bigint           indexed
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
  # belongs_to :business
   belongs_to :user
end
