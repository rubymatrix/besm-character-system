class CreateMoneyAdjustments < ActiveRecord::Migration[8.0]
  def change
    create_table :money_adjustments do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.integer :amount
      t.string :reason

      t.timestamps
    end
  end
end
