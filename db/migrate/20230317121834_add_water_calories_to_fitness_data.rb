class AddWaterCaloriesToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :water_calories, :float
  end
end
