class AddRemoteIdToSources < ActiveRecord::Migration[5.2]
  def up
    add_column :sources, :lookup_remote_id, :string
    add_column :sources, :mapto_name, :string
    add_column :sources, :mapto_description, :string
    add_column :sources, :mapto_url, :string
    add_column :sources, :mapto_cost, :string
    add_column :sources, :mapto_start_time, :string
    add_column :sources, :mapto_end_time, :string
  end

  def down
    remove_column :sources, :lookup_remote_id
    remove_column :sources, :lookup_remote_id
    remove_column :sources, :mapto_name
    remove_column :sources, :mapto_description
    remove_column :sources, :mapto_url
    remove_column :sources, :mapto_cost
    remove_column :sources, :mapto_start_time
    remove_column :sources, :mapto_end_time
  end
end
