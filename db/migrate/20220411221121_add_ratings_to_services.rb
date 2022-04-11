class AddRatingsToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :ratings, :float
  end
end
