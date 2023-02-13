class CreateCompleteActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :complete_activities do |t|
      t.integer :activity_id
      t.integer :user_id
      t.boolean :item_1
      t.boolean :item_2
      t.boolean :item_3
      t.boolean :item_4
      t.boolean :item_5

      t.timestamps
    end
  end
end
