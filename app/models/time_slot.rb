# == Schema Information
#
# Table name: time_slots
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TimeSlot < ApplicationRecord
  has_many :user_time_slots
end
