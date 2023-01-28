# == Schema Information
#
# Table name: training_programs
#
#  id             :bigint           not null, primary key
#  days           :string
#  training_level :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  trainer_id     :integer
#  user_id        :integer
#
class TrainingProgram < ApplicationRecord
  belongs_to :trainer
  belongs_to :user

  has_many :activities
end
