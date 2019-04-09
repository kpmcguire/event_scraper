class CreateVenues < ActiveRecord::Migration[5.2]
  def up
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :text
      t.string :url

      t.timestamps
    end
  end

  def def down 
    drop_table :venues
  end
end
