class UseBigintOnRemoteIds < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :remote_id, :bigint
  end

  def down
    change_column :events, :remote_id, :int
  end
end
