class AddPolymorphicFeedableReferenceToFeederItems < ActiveRecord::Migration
  def change
    add_reference :feeder_items, :feedable, polymorphic: true, index: true
  end
end
