class RemoveSourceIdFromVenuesAddVenueIdToSources < ActiveRecord::Migration[5.2]
  def up
    remove_column :venues, :source_id
    add_column :sources, :venue_id, :integer
  end

  def down
    add_column :venues, :source_id
    remove_column :sources, :venue_id    
  end
end
