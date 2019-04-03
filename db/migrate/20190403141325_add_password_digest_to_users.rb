class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column "users", "password"
    add_column "users", "password_digest", :string
  end

  def def down 
    remove_column "users", "password"
    add_column "users", "password", :string, :limit => 100
  end
end
