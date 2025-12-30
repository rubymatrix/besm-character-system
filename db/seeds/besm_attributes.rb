puts "Seeding BESM Attributes..."
attributes_path = Rails.root.join('besm-attribute-viewer', 'besm_attributes.json')
attributes = JSON.parse(File.read(attributes_path))

attributes.each do |attr|
  record = BesmAttribute.find_or_initialize_by(name: attr['name'])
  record.attribute_cost = attr['attribute_cost']
  record.cost_per_level = attr['attribute_cost'].to_i
  record.relevant_stat = attr['relevant_stat']
  record.description = attr['description']
  record.level_effects = attr['level_effects']
  record.save!
end
puts "Seeding BESM Attributes Done."
