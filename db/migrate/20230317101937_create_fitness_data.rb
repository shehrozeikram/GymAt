class CreateFitnessData < ActiveRecord::Migration[6.1]
  def change
    create_table :fitness_data do |t|
      t.boolean :burger, :default => false
      t.boolean :coke, :default => false
      t.boolean :water, :default => false
      t.string :date
      t.string :activity_id
      t.float :calories_gain
      t.float :calories_burn
      t.float :walking
      t.integer :exercise
      t.integer :steps
      t.string :running
      t.string :float
      t.float :total_hours
      t.float :blood_pressure

      t.timestamps
    end
  end
end
