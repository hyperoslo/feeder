class CreateFeederReports < ActiveRecord::Migration
  def change
    create_table :feeder_reports do |t|
      t.references :reporter, index: true, polymorphic: true
      t.references :item,     index: true

      t.timestamps
    end
  end
end
