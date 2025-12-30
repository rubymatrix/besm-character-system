class AddPointsToEquipmentEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :equipment_entries, :points, :integer
  end
end
