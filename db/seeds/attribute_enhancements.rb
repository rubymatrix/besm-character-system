puts "Seeding Attribute Enhancements..."
enhancements_path = Rails.root.join('besm-attribute-viewer', 'besm_enhancements.json')
enhancements = JSON.parse(File.read(enhancements_path))

enhancements.each do |enh|
  record = AttributeEnhancement.find_or_initialize_by(name: enh['name'])
  record.description = enh['description']
  record.assignment_effects = enh['assignment_effects']
  record.save!
end
puts "Seeding Attribute Enhancements Done."
