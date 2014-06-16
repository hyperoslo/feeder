class AddRecommendedToFeederItems < ActiveRecord::Migration
  def change
    add_column :feeder_items, :recommended, :boolean, default: false, null: false
  end
end
