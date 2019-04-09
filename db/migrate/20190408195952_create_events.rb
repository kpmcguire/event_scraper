class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :venue_id
      t.integer :organization_id
      t.string :name
      t.text :description
      t.string :url
      t.float :cost
      t.datetime :start_date
      t.datetime :end_date
      t.string :url

      t.timestamps
    end
  end
end
