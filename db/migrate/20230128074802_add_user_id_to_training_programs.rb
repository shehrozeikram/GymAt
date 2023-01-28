class AddUserIdToTrainingPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :training_programs, :user_id, :integer
  end
end
