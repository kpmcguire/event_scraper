class AlterUsers < ActiveRecord::Migration[5.2]
  def up
    add_column("users", "username", :string, :limit => 50, :after => "email")
    change_column("users", "email", :string, :limit => 100)
    add_index("users", "username")

  end

  def down
    remove_index("users", "username")
    change_column("users", "email", :string, :default => '', :null => false)
    remove_column("users", "username")
  end  
end
