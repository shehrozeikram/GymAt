# == Schema Information
#
# Table name: resturants
#
#  id          :bigint           not null, primary key
#  attachments :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Resturant < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  has_many :resturant_dishes
end
