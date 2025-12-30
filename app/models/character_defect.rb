# app/models/character_defect.rb
class CharacterDefect < ApplicationRecord
  belongs_to :character_sheet, inverse_of: :character_defects

  validates :name, presence: true
  validates :rank, :bp, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end