class AddAttachmentsToCamels < ActiveRecord::Migration[6.1]
  def change
    add_column :camels, :attachments, :text
  end
end
