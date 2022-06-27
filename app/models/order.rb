# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  comment          :string
#  coupon           :string
#  delivery_address :string
#  order_detail     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Order < ApplicationRecord
end
