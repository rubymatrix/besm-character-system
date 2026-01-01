# db/migrate/20250917121500_split_acv_dcv_values.rb
class SplitAcvDcvValues < ActiveRecord::Migration[8.0]
  def up
    add_column :character_sheets, :melee_acv, :integer, null: false, default: 6
    add_column :character_sheets, :ranged_acv, :integer, null: false, default: 6
    add_column :character_sheets, :melee_dcv, :integer, null: false, default: 6
    add_column :character_sheets, :ranged_dcv, :integer, null: false, default: 6

    execute <<~SQL
      UPDATE character_sheets
      SET melee_acv = acv,
          ranged_acv = acv,
          melee_dcv = dcv,
          ranged_dcv = dcv
    SQL

    remove_column :character_sheets, :acv, :integer
    remove_column :character_sheets, :dcv, :integer
  end

  def down
    add_column :character_sheets, :acv, :integer, null: false, default: 6
    add_column :character_sheets, :dcv, :integer, null: false, default: 6

    execute <<~SQL
      UPDATE character_sheets
      SET acv = melee_acv,
          dcv = melee_dcv
    SQL

    remove_column :character_sheets, :melee_acv, :integer
    remove_column :character_sheets, :ranged_acv, :integer
    remove_column :character_sheets, :melee_dcv, :integer
    remove_column :character_sheets, :ranged_dcv, :integer
  end
end
