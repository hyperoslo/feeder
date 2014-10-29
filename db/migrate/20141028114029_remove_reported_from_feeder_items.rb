class RemoveReportedFromFeederItems < ActiveRecord::Migration
  def change
    remove_column :feeder_items, :reported, :boolean, default: false, null: false
  end
end
