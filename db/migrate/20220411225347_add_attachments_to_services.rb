class AddAttachmentsToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :attachments, :text
  end
end
