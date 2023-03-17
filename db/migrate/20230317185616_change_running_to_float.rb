class ChangeRunningToFloat < ActiveRecord::Migration[6.1]
  def change
    safety_assured {remove_column :fitness_data, :running}
    add_column :fitness_data, :running, :float
  end
end
