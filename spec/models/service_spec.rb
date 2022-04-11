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
require 'rails_helper'

RSpec.describe Service, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
