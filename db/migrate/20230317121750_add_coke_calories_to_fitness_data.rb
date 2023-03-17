class AddCokeCaloriesToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :coke_calories, :float
  end
end
