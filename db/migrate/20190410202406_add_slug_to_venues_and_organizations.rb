class AddSlugToVenuesAndOrganizations < ActiveRecord::Migration[5.2]
  def up
    add_column :venues, :slug, :string
    add_column :organizations, :slug, :string
    add_index :venues, :slug, :unique => true
    add_index :organizations, :slug, :unique => true
  end

  def def down 
    remove_column :venues, :slug
    remove_column :organizations, :slug
    remove_index :venues, name: :slug
    remove_index :organizations, name: :slug
  end
end
