# == Schema Information
#
# Table name: resturant_dishes
#
#  id            :bigint           not null, primary key
#  attachments   :text
#  order_counter :integer
#  price         :float
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resturant_id  :integer
#
class ResturantDish < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  belongs_to :resturant
  has_many :dish_orders

end
