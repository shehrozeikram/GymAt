class CreateTrainers < ActiveRecord::Migration[6.1]
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :trainer_type
      t.float :rating
      t.text :attachments
      t.text :avatar

      t.timestamps
    end
  end
end
