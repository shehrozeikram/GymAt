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
#  user_id             :integer
#
# Indexes
#
#  index_services_on_service_provider_id  (service_provider_id)
#
FactoryBot.define do
  factory :service do
    
  end
end
