class ChangeCostToStringOnEvents < ActiveRecord::Migration[5.2]
  def up
    remove_column :venues, :venue_string, :string
    change_column :events, :cost, :string
  end

  def down
    add_column :venues, :venue_string, :string
    change_column :events, :cost, :float
  end
end
