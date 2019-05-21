class UseIntLimitOnRemoteIds < ActiveRecord::Migration[5.2]
  def up
    change_column :venues, :remote_id, :int
  end

  def down
    change_column :venues, :remote_id, :bigint
  end
end
