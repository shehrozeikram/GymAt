class AddBurgerCaloriesToFitnessData < ActiveRecord::Migration[6.1]
  def change
    add_column :fitness_data, :burger_calories, :float
  end
end
