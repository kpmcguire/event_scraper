class AddMaptToIDtoSources < ActiveRecord::Migration[5.2]
  def up
    add_column :sources, :mapto_id, :string
  end

  def down
    remove_column :sources, :mapto_id
  end
end
