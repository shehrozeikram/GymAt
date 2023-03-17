class AddExerciseCaloriesToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :exercise_calories, :float
  end
end
