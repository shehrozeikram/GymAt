# == Schema Information
#
# Table name: shops
#
#  id          :bigint           not null, primary key
#  attachments :text
#  description :string
#  price       :float
#  quantity    :integer
#  shop_type   :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Shop < ApplicationRecord

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  belongs_to :user
  has_many :checkouts
end
