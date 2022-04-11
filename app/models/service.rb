# == Schema Information
#
# Table name: services
#
#  id                  :bigint           not null, primary key
#  ar_description      :string
#  ar_title            :string
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
  belongs_to :business
  belongs_to :user
end
