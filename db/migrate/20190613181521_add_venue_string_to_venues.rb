class AddVenueStringToVenues < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :venue_string, :string
  end

  def down
    remove_column :venues, :venue_string, :string
  end
end
