class AddServiceIdToAppoinments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :service_id, :integer
  end
end
