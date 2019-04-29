class AddRemoteIdToEvents < ActiveRecord::Migration[5.2]
  def up
    add_column :events, :remote_id, :integer
  end

  def down
    remove_column :events, :remote_id
  end  
end
