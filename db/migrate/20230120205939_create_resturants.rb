class CreateResturants < ActiveRecord::Migration[6.1]
  def change
    create_table :resturants do |t|
      t.string :title
      t.text :attachments

      t.timestamps
    end
  end
end
