class RenameSourceType < ActiveRecord::Migration[5.2]
  def up
    rename_column :sources, :type, :feed_type
  end

  def down
    rename_column :sources, :feed_type, :type
  end  
end
