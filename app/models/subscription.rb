# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  amount            :string
#  business_type     :string
#  discount          :string
#  full_name         :string
#  special_offer     :string
#  start_date        :date
#  subscription_type :string
#  total_amount      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  business_id       :integer
#  payment_id        :integer
#  user_id           :integer
#
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :business
  has_many :payments
end
