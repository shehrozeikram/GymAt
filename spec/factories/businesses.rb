# == Schema Information
#
# Table name: businesses
#
#  id             :bigint           not null, primary key
#  ar_description :string
#  ar_title       :string
#  title          :string
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :business do
    
  end
end
