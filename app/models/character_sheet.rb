# app/models/character_sheet.rb
class CharacterSheet < ApplicationRecord
  has_many :character_attributes, dependent: :destroy, inverse_of: :character_sheet
  has_many :character_defects,    dependent: :destroy, inverse_of: :character_sheet
  has_many :equipment_entries,    dependent: :destroy, inverse_of: :character_sheet
  has_many :character_point_adjustments, dependent: :destroy
  has_many :money_adjustments, dependent: :destroy

  accepts_nested_attributes_for :character_attributes, allow_destroy: true
  accepts_nested_attributes_for :character_defects,    allow_destroy: true
  accepts_nested_attributes_for :equipment_entries,    allow_destroy: true

  validates :character_name, :player_name, presence: true
  validates :character_points, :body, :mind, :soul,
            :melee_acv, :ranged_acv, :melee_dcv, :ranged_dcv,
            :health_points, :energy_points, :absorb, :armor,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :money, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  before_validation :ensure_armor_absorb

  def ensure_armor_absorb
    self.absorb ||= 0
    self.armor ||= 0
  end

  # --- Hooks for future auto-calculation (optional) ---
  # Uncomment if you later want to compute derived values from core stats.
  # before_validation :compute_defaults, on: :create
  #
  # def compute_defaults
  #   self.melee_acv ||= (body + mind) / 2
  #   self.ranged_acv ||= (body + mind) / 2
  #   self.melee_dcv ||= (body + soul) / 2
  #   self.ranged_dcv ||= (body + soul) / 2
  #   self.health_points  ||= body * 10
  #   self.energy_points  ||= mind * 5 + soul * 5
  # end
  # --- Back-compat helpers for the current view ---
  def attributes_list
    character_attributes.map do |a|
      { name: a.name, level: a.level, points: a.cost_points, notes: a.notes, draft: a.draft }
    end
  end

  def defects_list
    character_defects.map { |d| { name: d.name, rank: d.rank, bp: d.bp } }
  end

  def equipment
    equipment_entries.map do |e|
      {
        kind: e.kind.humanize,                           # e.g., "Weapon"
        name: e.name,
        note: (e.summary.presence || e.notes.to_s)       # what the view calls :note
      }
    end
  end

  def total_attribute_points
    character_attributes.select { |a| !a.draft? }.sum { |a| a.cost_points }
  end

  def total_defect_bp
    character_defects.sum(:bp)
  end

  def total_equipment_points
    equipment_entries.where(draft: false).sum(:points)
  end

  def cp_budget
    character_points + character_point_adjustments.sum(:points)
  end

  def cp_spent
    total_attribute_points - total_defect_bp + total_equipment_points + (body + mind + soul) * 2
  end

  def cp_balance
    cp_budget - cp_spent
  end

  def total_money
    (money || 0) + money_adjustments.sum(:amount)
  end

  def money_breakdown(amount = total_money)
    abs_amount = amount.abs
    gold = abs_amount / 10000
    silver = (abs_amount % 10000) / 100
    copper = abs_amount % 100
    { gold: gold, silver: silver, copper: copper, negative: amount < 0 }
  end

  def format_currency(amount = total_money)
    breakdown = money_breakdown(amount)
    parts = []
    parts << "#{breakdown[:gold]}g" if breakdown[:gold] > 0
    parts << "#{breakdown[:silver]}s" if breakdown[:silver] > 0 || parts.any?
    parts << "#{breakdown[:copper]}c"

    formatted = parts.join(" ")
    breakdown[:negative] ? "-#{formatted}" : formatted
  end

  def total_cp
    cp_budget
  end
end
