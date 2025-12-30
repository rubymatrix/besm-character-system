class CreateAttributeEnhancements < ActiveRecord::Migration[8.0]
  def change
    create_table :attribute_enhancements do |t|
      t.string :name
      t.text :description
      t.json :assignment_effects

      t.timestamps
    end
  end
end
