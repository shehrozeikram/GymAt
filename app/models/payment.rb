# == Schema Information
#
# Table name: payments
#
#  id            :bigint           not null, primary key
#  card_number   :string
#  cvc           :string
#  expiring_date :date
#  name_of_card  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Payment < ApplicationRecord
  belongs_to :subscription
end
