class AddRemoteId < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :remote_id, :text
  end
  def down
    remove_column :venues, :remote_id
  end
end
