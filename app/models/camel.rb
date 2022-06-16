# == Schema Information
#
# Table name: camels
#
#  id            :bigint           not null, primary key
#  age           :integer
#  awards        :string
#  bid_type      :string
#  camel_purpose :string
#  camel_type    :string
#  description   :string
#  gender        :string
#  name          :string
#  owner_name    :string
#  price         :integer
#  rent_purpose  :string
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Camel < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  acts_as_taggable_on :tags
  acts_as_taggable_on :service_types

  belongs_to :user

end
