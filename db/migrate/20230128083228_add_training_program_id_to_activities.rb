class AddTrainingProgramIdToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :training_program_id, :integer
  end
end
