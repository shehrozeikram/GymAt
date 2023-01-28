# == Schema Information
#
# Table name: trainers
#
#  id           :bigint           not null, primary key
#  attachments  :text
#  avatar       :text
#  name         :string
#  rating       :float
#  subscribers  :integer          default(0)
#  trainer_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Trainer < ApplicationRecord

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  mount_uploaders :avatar, AvatarUploader
  serialize :avatar, JSON

  has_many :trainer_subscriptions
  has_many :training_programs

end
