class AddDraftToCharacterAttributesAndEquipmentEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :character_attributes, :draft, :boolean, null: false, default: false
    add_column :equipment_entries, :draft, :boolean, null: false, default: false
  end
end
