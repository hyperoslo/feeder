class AddUnpublishedAtToFeederItem < ActiveRecord::Migration
  def change
    add_column :feeder_items, :unpublished_at, :datetime
  end
end
