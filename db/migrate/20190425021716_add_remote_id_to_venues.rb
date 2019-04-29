class AddRemoteIdToVenues < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :remote_id, :integer
  end

  def down
    remove_column :venues, :remote_id
  end  
end
