class CreateServiceAvailablities < ActiveRecord::Migration[6.1]
  def change
    create_table :service_availabilities do |t|
      t.boolean :saturday
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.belongs_to :service
      t.timestamps
    end
  end
end
