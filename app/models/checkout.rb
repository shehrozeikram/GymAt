# == Schema Information
#
# Table name: checkouts
#
#  id            :bigint           not null, primary key
#  attachments   :text
#  discount      :float
#  free_delivery :boolean
#  price         :float
#  quantity      :integer
#  shipping_fee  :string
#  sub_total     :float
#  title         :string
#  total         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  payment_id    :integer
#  shop_id       :integer
#  user_id       :integer
#
class Checkout < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  belongs_to :user
  belongs_to :shop
  has_many :payments

end
