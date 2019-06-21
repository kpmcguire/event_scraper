class AddRatingsToVenues < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :rating, :float
    add_column :organizations, :rating, :float
    add_column :events, :rating, :float
  end

  def down
    remove_column :venues, :rating, :float
    remove_column :organizations, :rating, :float
    remove_column :events, :rating, :float
  end  
end
