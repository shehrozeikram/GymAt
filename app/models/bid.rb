# == Schema Information
#
# Table name: bids
#
#  id         :bigint           not null, primary key
#  bid_amount :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  camel_id   :integer
#  user_id    :integer
#
class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :camel
end
