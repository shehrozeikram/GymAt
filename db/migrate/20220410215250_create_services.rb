class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :title
      t.string :ar_title
      t.string :ar_description
      t.string :type
      t.belongs_to :service_provider
      t.timestamps
    end
  end
end
