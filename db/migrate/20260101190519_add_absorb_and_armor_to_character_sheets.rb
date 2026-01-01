class AddAbsorbAndArmorToCharacterSheets < ActiveRecord::Migration[8.0]
  def change
    add_column :character_sheets, :absorb, :integer
    add_column :character_sheets, :armor, :integer
  end
end
