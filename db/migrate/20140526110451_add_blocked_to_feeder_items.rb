class AddBlockedToFeederItems < ActiveRecord::Migration
  def change
    add_column :feeder_items, :blocked, :boolean, null: false, default: false
  end
end
