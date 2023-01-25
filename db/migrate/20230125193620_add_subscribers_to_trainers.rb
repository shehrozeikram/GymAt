class AddSubscribersToTrainers < ActiveRecord::Migration[6.1]
  def change
    add_column :trainers, :subscribers, :integer, :default => 0
  end
end
