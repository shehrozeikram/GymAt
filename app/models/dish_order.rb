# == Schema Information
#
# Table name: dish_orders
#
#  id                :bigint           not null, primary key
#  delivery          :float
#  discount          :float
#  latitude          :float
#  longitude         :float
#  order_completed   :boolean          default(FALSE)
#  quantity          :integer
#  self_pickup       :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  payment_id        :integer
#  resturant_dish_id :integer
#  user_id           :integer
#
class DishOrder < ApplicationRecord
  belongs_to :user
  belongs_to :resturant_dish
  has_many :payments
end
