class AddAttachmentsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :attachments, :text
  end
end
