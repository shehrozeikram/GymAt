class AddWalkingCaloriesToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :walking_calories, :float
  end
end
