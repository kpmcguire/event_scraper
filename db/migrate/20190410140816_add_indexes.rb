class AddIndexes < ActiveRecord::Migration[5.2]
  def up
    add_index("events", "name")
    add_index("events", "venue_id")
    add_index("events", "organization_id")
    add_index("venues", "name")
    add_index("organizations", "name")
  end

  def down 
    remove_index("events", "name")
    remove_index("events", "venue_id")
    remove_index("events", "organization_id")
    remove_index("venues", "name")
    remove_index("organizations", "name")
  end
end
