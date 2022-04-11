class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :title
      t.string :ar_title
      t.string :ar_description
      t.string :type
      t.timestamps
    end
  end
end
