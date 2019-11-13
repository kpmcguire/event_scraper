class AddRemoteIdsColumn < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :remote_id, :int, :limit => 8, array: true
  end
  def down
    remove_column :venues, :remote_id
  end  
end
