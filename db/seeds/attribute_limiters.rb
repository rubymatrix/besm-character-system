puts "Seeding Attribute Limiters..."
limiters_path = Rails.root.join('besm-attribute-viewer', 'besm_limiters.json')
limiters = JSON.parse(File.read(limiters_path))

limiters.each do |lim|
  record = AttributeLimiter.find_or_initialize_by(name: lim['name'])
  record.description = lim['description']
  record.assignment_effects = lim['assignment_effects']
  record.save!
end
puts "Seeding Attribute Limiters Done."
