puts "Seeding Weapon Limiters..."
weapon_limiters_path = Rails.root.join('besm-attribute-viewer', 'besm_weapon_limiters.json')
weapon_limiters = JSON.parse(File.read(weapon_limiters_path))

weapon_limiters.each do |wl|
  record = WeaponLimiter.find_or_initialize_by(name: wl['name'])
  record.ranks = wl['ranks']
  record.description = wl['description']
  record.save!
end
puts "Seeding Weapon Limiters Done."
