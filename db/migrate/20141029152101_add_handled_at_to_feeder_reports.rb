class AddHandledAtToFeederReports < ActiveRecord::Migration
  def change
    add_column :feeder_reports, :handled_at, :datetime
  end
end
