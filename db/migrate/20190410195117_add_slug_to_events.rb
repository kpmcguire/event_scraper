class AddSlugToEvents < ActiveRecord::Migration[5.2]
  def up
    add_column :events, :slug, :string
    add_index :events, :slug, :unique => true
  end

  def def down 
    remove_column :events, :slug
    remove_index :events, name: :slug
  end
end
