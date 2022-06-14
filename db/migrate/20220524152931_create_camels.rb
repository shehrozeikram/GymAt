class CreateCamels < ActiveRecord::Migration[6.1]
  def change
    create_table :camels do |t|
      t.string :name
      t.string :type
      t.string :gender
      t.integer :age
      t.string :awards
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
