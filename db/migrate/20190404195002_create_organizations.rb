class CreateOrganizations < ActiveRecord::Migration[5.2]
  def up
    create_table :organizations do |t|
      t.string :name, :limit => 100
      t.string :address, :limit => 100
      t.text :description
      t.timestamps
    end
  end

  def down 
    drop_table :organizations 
  end
end
