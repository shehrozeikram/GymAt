class CreateServiceAvailablities < ActiveRecord::Migration[6.1]
  def change
    create_table :service_availabilities do |t|
      t.timestamps
    end
  end
end
