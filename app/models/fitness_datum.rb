# == Schema Information
#
# Table name: fitness_data
#
#  id                :bigint           not null, primary key
#  blood_pressure    :float
#  burger            :boolean          default(FALSE)
#  burger_calories   :float
#  calories_burn     :float
#  calories_gain     :float
#  coke              :boolean          default(FALSE)
#  coke_calories     :float
#  date              :string
#  exercise          :integer
#  exercise_calories :float
#  float             :string
#  running           :float
#  running_calories  :float
#  steps             :integer
#  total_hours       :float
#  walking           :float
#  walking_calories  :float
#  water             :boolean          default(FALSE)
#  water_calories    :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  activity_id       :string
#  user_id           :integer
#
class FitnessDatum < ApplicationRecord
  belongs_to :activity
  belongs_to :user
end
