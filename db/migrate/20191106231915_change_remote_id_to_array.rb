class ChangeRemoteIdToArray < ActiveRecord::Migration[5.2]
  def up
    remove_index :venues, :remote_id
    remove_column :venues, :remote_id
  end

  def down
    add_column :venues, :remote_id, :bigint
  end
end
