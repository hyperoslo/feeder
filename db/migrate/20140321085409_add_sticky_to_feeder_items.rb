class AddStickyToFeederItems < ActiveRecord::Migration
  def change
    add_column :feeder_items, :sticky, :boolean, default: false
  end
end
