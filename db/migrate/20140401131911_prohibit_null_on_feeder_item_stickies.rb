class ProhibitNullOnFeederItemStickies < ActiveRecord::Migration
  class Feeder::Item < ActiveRecord::Base; end

  def up
    Feeder::Item.where(sticky: nil).update_all sticky: false

    change_column :feeder_items, :sticky, :boolean, null: false
  end

  def down
    change_column :feeder_items, :sticky, :boolean, null: true
  end
end
