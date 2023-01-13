class AddBusinessIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :business_id, :integer
  end
end
