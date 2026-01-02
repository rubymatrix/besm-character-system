# app/models/character_defect.rb
class CharacterDefect < ApplicationRecord
  belongs_to :character_sheet, inverse_of: :character_defects
  has_many :adjusters, as: :adjustable, dependent: :destroy
  accepts_nested_attributes_for :adjusters, allow_destroy: true, reject_if: ->(attrs) { attrs["stat"].blank? }

  validates :name, presence: true
  validates :rank, :bp, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
