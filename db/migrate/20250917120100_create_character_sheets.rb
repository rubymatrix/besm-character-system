# db/migrate/20250917120100_create_character_sheets.rb
class CreateCharacterSheets < ActiveRecord::Migration[8.0]
  def change
    create_table :character_sheets do |t|
      # Header / meta
      t.string  :character_name,      null: false
      t.string  :player_name,         null: false
      t.string  :gm_name
      t.integer :character_points,    null: false, default: 0

      # Identity
      t.string  :race
      t.string  :occupation
      t.string  :habitat
      t.string  :size_height_weight_gender

      # Core stats
      t.integer :body,                null: false, default: 6
      t.integer :mind,                null: false, default: 6
      t.integer :soul,                null: false, default: 6

      # Derived (let these be editable even if you later compute them)
      t.integer :acv,                 null: false, default: 6
      t.integer :dcv,                 null: false, default: 6
      t.integer :health_points,       null: false, default: 30
      t.integer :energy_points,       null: false, default: 20
      t.string  :damage_multiplier,   null: false, default: "x2"

      # Notes
      t.text    :game_notes

      t.timestamps
    end

    add_index :character_sheets, :character_name
    add_index :character_sheets, :player_name
  end
end
