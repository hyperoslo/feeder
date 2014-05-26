class AddReportedToFeederItems < ActiveRecord::Migration
  def change
    add_column :feeder_items, :reported, :boolean, null: false, default: false
  end
end
