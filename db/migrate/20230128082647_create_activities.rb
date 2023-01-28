class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.text :attachments
      t.string :title
      t.integer :times
      t.integer :minutes
      t.integer :calories
      t.integer :avg_frequency
      t.integer :max_frequency
      t.integer :breaks
      t.float :breaks_time

      t.timestamps
    end
  end
end
