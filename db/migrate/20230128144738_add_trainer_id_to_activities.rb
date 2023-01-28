class AddTrainerIdToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :trainer_id, :integer
  end
end
