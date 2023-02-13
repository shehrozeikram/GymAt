# == Schema Information
#
# Table name: activities
#
#  id                  :bigint           not null, primary key
#  attachments         :text
#  avg_frequency       :integer
#  breaks              :integer
#  breaks_time         :float
#  calories            :integer
#  day                 :string
#  max_frequency       :integer
#  minutes             :integer
#  times               :integer
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  trainer_id          :integer
#  training_program_id :integer
#
class Activity < ApplicationRecord

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  belongs_to :training_program
  belongs_to :trainer

  has_many :complete_activities
end
