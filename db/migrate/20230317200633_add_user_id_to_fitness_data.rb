class AddUserIdToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :user_id, :integer
  end
end
