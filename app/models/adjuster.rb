class Adjuster < ApplicationRecord
  belongs_to :adjustable, polymorphic: true

  enum :stat, {
    body: 0,
    mind: 1,
    soul: 2,
    health: 3,
    energy: 4,
    damage_multiplier: 5,
    melee_acv: 6,
    ranged_acv: 7,
    melee_dcv: 8,
    ranged_dcv: 9,
    armor: 10,
    absorb: 11
  }

  validates :stat, presence: true
  validates :amount, numericality: { only_integer: true }
end
