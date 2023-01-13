# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  body        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer
#  user_id     :integer
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :business
end
