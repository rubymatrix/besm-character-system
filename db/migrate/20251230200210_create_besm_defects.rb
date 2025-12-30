class CreateBesmDefects < ActiveRecord::Migration[8.0]
  def change
    create_table :besm_defects do |t|
      t.string :name
      t.string :defect_type
      t.text :description
      t.json :rank_effects

      t.timestamps
    end
  end
end
