class CreateWeaponEnhancements < ActiveRecord::Migration[8.0]
  def change
    create_table :weapon_enhancements do |t|
      t.string :name
      t.string :ranks
      t.text :description

      t.timestamps
    end
  end
end
