# db/migrate/20250917120200_create_character_attributes.rb
class CreateCharacterAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :character_attributes do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string  :name,  null: false
      t.integer :level, null: false, default: 1
      t.integer :points, null: false, default: 0
      t.text    :notes
      t.timestamps
    end

    add_index :character_attributes, [:character_sheet_id, :name]
  end
end
