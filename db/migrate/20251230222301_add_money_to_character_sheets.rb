class AddMoneyToCharacterSheets < ActiveRecord::Migration[8.0]
  def change
    add_column :character_sheets, :money, :integer
  end
end
