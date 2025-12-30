# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
astra = CharacterSheet.create!(
  character_name: "Renji Sato",
  player_name: "Josh",
  gm_name: "Jason",
  character_points: 56,
  race: "Reincarnated Human",
  occupation: "Reaper",
  habitat: "Neo-Tokyo",
  size_height_weight_gender: "M • 5'9\" • 72kg",
  body: 4, mind: 4, soul: 4,
  acv: 6, dcv: 5, health_points: 55, energy_points: 40, damage_multiplier: "x2",
  game_notes: "Rescue on the Orbital Lift; Syndicate presence confirmed."
)

astra.character_attributes.create!([
                                     { name: "Combat Technique: Starblade", level: 2, points: 8, notes: "+1 ACV when charged" },
                                     { name: "Heightened Senses", level: 1, points: 2 },
                                     { name: "Item of Power: Photon Katana", level: 1, points: 4 }
                                   ])

astra.character_defects.create!([
                                  { name: "Marked", rank: 1, bp: 1 },
                                  { name: "Enemy: Syndicate", rank: 2, bp: 2 }
                                ])

astra.equipment_entries.create!([
                                  { kind: :weapon,   name: "Photon Katana",    summary: "+1 ACV, x2 DM when charged" },
                                  { kind: :companion, name: "Drone: Hikari",     summary: "Scouting; +1 Mind checks" }
                                ])

# Load BESM seeds
Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
