# == Schema Information
#
# Table name: trainer_videos
#
#  id         :bigint           not null, primary key
#  videos     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trainer_id :integer
#
class TrainerVideo < ApplicationRecord

  mount_uploaders :videos, VideoUploader
  serialize :videos, JSON

  belongs_to :trainer
end
