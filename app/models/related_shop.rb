# == Schema Information
#
# Table name: related_shops
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
#  shop_id     :integer
#  user_id     :integer
#
class RelatedShop < ApplicationRecord

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON
  belongs_to :user
  belongs_to :shop
end
