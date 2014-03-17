class CreateFeederItems < ActiveRecord::Migration
  def change
    create_table :feeder_items do |t|
      t.datetime :published_at

      t.timestamps
    end
  end
end
