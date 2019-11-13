class RevertRemoteIdToBigint < ActiveRecord::Migration[5.2]
  def up
    remove_column :venues, :remote_id
    add_column :venues, :remote_id, :bigint
  end
  def down
    remove_column :venues, :remote_id
    add_column :venues, :remote_id, :text
  end
end
