# app/models/character_attribute.rb
class CharacterAttribute < ApplicationRecord
  belongs_to :character_sheet, inverse_of: :character_attributes

  validates :name, presence: true
  validates :level, :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end