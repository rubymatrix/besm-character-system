class CreateAdjusters < ActiveRecord::Migration[7.1]
  def change
    create_table :adjusters do |t|
      t.references :adjustable, null: false, polymorphic: true
      t.integer :stat, null: false
      t.integer :amount, null: false, default: 0
      t.string :condition

      t.timestamps
    end
  end
end
