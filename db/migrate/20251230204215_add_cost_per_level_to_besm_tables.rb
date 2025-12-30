class AddCostPerLevelToBesmTables < ActiveRecord::Migration[8.0]
  def change
    add_column :besm_attributes, :cost_per_level, :integer
    add_column :besm_defects, :cost_per_level, :integer
    add_column :attribute_enhancements, :cost_per_level, :integer
    add_column :attribute_limiters, :cost_per_level, :integer
    add_column :weapon_enhancements, :cost_per_level, :integer
    add_column :weapon_limiters, :cost_per_level, :integer
  end
end
