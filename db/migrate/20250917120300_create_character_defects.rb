# db/migrate/20250917120300_create_character_defects.rb
class CreateCharacterDefects < ActiveRecord::Migration[8.0]
  def change
    create_table :character_defects do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string  :name,  null: false
      t.integer :rank,  null: false, default: 1
      t.integer :bp,    null: false, default: 0 # Bonus Points gained
      t.text    :notes
      t.timestamps
    end

    add_index :character_defects, [:character_sheet_id, :name]
  end
end
