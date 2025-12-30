class CreateCharacterPointAdjustments < ActiveRecord::Migration[8.0]
  def change
    create_table :character_point_adjustments do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.integer :points
      t.string :reason

      t.timestamps
    end
  end
end
