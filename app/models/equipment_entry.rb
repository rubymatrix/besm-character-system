# app/models/equipment_entry.rb
class EquipmentEntry < ApplicationRecord
  belongs_to :character_sheet, inverse_of: :equipment_entries
  has_many :adjusters, as: :adjustable, dependent: :destroy
  accepts_nested_attributes_for :adjusters, allow_destroy: true, reject_if: ->(attrs) { attrs["stat"].blank? }

  enum :kind, {
    weapon: 0,
    armour: 1,
    companion: 2,
    item: 3,
    vehicle: 4,
    npc: 5,
    other: 6
  }

  validates :name, presence: true
end
