class AddNameToSources < ActiveRecord::Migration[5.2]
  def up
    add_column :sources, :name, :string
  end

  def down
    remove_column :sources, :name
  end
end
