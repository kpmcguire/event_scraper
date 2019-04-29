class AddIndexToRemoteIdOnVenues < ActiveRecord::Migration[5.2]
  def up
    add_index :venues, :remote_id
  end

  def down
    remove_index :venues, :remote_id
  end
end
