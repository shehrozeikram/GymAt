# == Schema Information
#
# Table name: businesses
#
#  id            :bigint           not null, primary key
#  attachments   :text
#  business_type :string
#  city          :string
#  closing_time  :string
#  description   :string
#  distance      :float
#  latitude      :float
#  longitude     :float
#  opening_time  :string
#  price         :integer
#  ratings       :float
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Business < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  acts_as_taggable_on :tags

  belongs_to :user
  has_many :reviews
  has_many :subscriptions
end
