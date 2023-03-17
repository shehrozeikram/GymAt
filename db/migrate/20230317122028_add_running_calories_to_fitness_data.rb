class AddRunningCaloriesToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :running_calories, :float
  end
end
