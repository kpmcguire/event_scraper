class UseBigintOnVenueRemoteIds < ActiveRecord::Migration[5.2]
  def up
    change_column :venues, :remote_id, :bigint
  end

  def down
    change_column :venues, :remote_id, :int
  end
end



