class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :header
      t.text :body

      t.timestamps
    end
  end
end
