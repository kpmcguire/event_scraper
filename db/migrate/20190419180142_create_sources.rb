class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.integer :type
      t.string :feed_url
      t.integer :lookup_id
      t.string :lookup_name
      t.string :lookup_description
      t.string :lookup_url
      t.string :lookup_cost
      t.string :lookup_start_time
      t.string :lookup_end_time

      t.timestamps
    end
  end
end
