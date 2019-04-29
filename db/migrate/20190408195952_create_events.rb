class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :venue_id
      t.integer :organization_id
      t.string :name
      t.text :description
      t.string :url
      t.float :cost
      t.datetime :start_time
      t.datetime :end_time
      t.string :url

      t.timestamps
    end
  end
end
