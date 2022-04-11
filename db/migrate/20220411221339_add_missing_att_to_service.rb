class AddMissingAttToService < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :description, :text

  end
end
