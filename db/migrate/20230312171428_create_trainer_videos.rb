class CreateTrainerVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :trainer_videos do |t|
      t.text :videos
      t.integer :trainer_id

      t.timestamps
    end
  end
end
