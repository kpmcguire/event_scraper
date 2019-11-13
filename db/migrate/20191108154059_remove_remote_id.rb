class RemoveRemoteId < ActiveRecord::Migration[5.2]
  def up
    remove_column :venues, :remote_id
  end
  def down 
    add_column :venues, :remote_id, :int, :limit => 8, array: true
  end
end
