# db/migrate/20250917120400_create_equipment_entries.rb
class CreateEquipmentEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :equipment_entries do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0 # enum
      t.string  :name, null: false
      t.string  :summary
      t.text    :notes
      t.timestamps
    end

    add_index :equipment_entries, [:character_sheet_id, :kind]
  end
end
