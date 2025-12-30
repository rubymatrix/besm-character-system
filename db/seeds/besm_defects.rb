puts "Seeding BESM Defects..."
defects_path = Rails.root.join('besm-attribute-viewer', 'besm_defects.json')
defects = JSON.parse(File.read(defects_path))

defects.each do |defect|
  record = BesmDefect.find_or_initialize_by(name: defect['name'])
  record.defect_type = defect['defect_type']
  # Derive cost per level from the first rank effect's points (absolute value)
  if defect['rank_effects'].present? && defect['rank_effects'].is_a?(Array)
    first_rank_points = defect['rank_effects'].first['points'].to_i
    record.cost_per_level = first_rank_points.abs
  end
  record.description = defect['description']
  record.rank_effects = defect['rank_effects']
  record.save!
end
puts "Seeding BESM Defects Done."
