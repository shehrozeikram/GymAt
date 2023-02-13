# == Schema Information
#
# Table name: complete_activities
#
#  id          :bigint           not null, primary key
#  item_1      :boolean
#  item_2      :boolean
#  item_3      :boolean
#  item_4      :boolean
#  item_5      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :integer
#  user_id     :integer
#
class CompleteActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity
end
