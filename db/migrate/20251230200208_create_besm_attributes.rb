class CreateBesmAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :besm_attributes do |t|
      t.string :name
      t.string :attribute_cost
      t.string :relevant_stat
      t.text :description
      t.json :level_effects

      t.timestamps
    end
  end
end
