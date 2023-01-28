class CreateTrainingPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :training_programs do |t|
      t.integer :training_level
      t.string :days
      t.integer :trainer_id

      t.timestamps
    end
  end
end
