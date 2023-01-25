# == Schema Information
#
# Table name: trainer_subscriptions
#
#  id         :bigint           not null, primary key
#  date       :date
#  time       :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trainer_id :integer
#  user_id    :integer
#
class TrainerSubscription < ApplicationRecord
  belongs_to :trainer
  belongs_to :user
end
