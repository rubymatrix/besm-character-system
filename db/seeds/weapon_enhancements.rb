puts "Seeding Weapon Enhancements..."
weapon_enhancements_path = Rails.root.join('besm-attribute-viewer', 'besm_weapon_enhancements.json')
weapon_enhancements = JSON.parse(File.read(weapon_enhancements_path))

weapon_enhancements.each do |we|
  record = WeaponEnhancement.find_or_initialize_by(name: we['name'])
  record.ranks = we['ranks']
  record.description = we['description']
  record.save!
end
puts "Seeding Weapon Enhancements Done."
