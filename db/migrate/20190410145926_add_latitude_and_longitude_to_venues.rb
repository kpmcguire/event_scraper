class AddLatitudeAndLongitudeToVenues < ActiveRecord::Migration[5.2]
  def up
    add_column "venues", "latitude", :float
    add_column "venues", "longitude", :float
  end

  def def down 
    remove_column "venues", "latitude", :float
    remove_column "venues", "longitude", :float
  end
end
