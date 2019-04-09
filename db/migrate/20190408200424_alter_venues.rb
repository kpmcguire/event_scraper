class AlterVenues < ActiveRecord::Migration[5.2]
  def up
    change_column :venues, :description, :text
    remove_column :venues, :text
  end

  def def down 
    change_column :venues, :description, :string
    add_column :venues, :text  
  end
end
