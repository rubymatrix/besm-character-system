class CreateWeaponLimiters < ActiveRecord::Migration[8.0]
  def change
    create_table :weapon_limiters do |t|
      t.string :name
      t.string :ranks
      t.text :description

      t.timestamps
    end
  end
end
