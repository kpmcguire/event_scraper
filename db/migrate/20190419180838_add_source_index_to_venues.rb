class AddSourceIndexToVenues < ActiveRecord::Migration[5.2]
  def up
    add_index("venues", "source_id")
  end

  def down
    remove_index("venues", "source_id")
  end  
end
