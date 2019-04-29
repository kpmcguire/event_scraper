class AddSourceIdToVenue < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :source_id, :integer
  end

  def down
    remove_column :venues, :source_id, :integer
  end  
end
