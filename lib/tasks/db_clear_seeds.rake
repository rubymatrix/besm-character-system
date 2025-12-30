namespace :db do
  desc "Delete only BESM reference data (Attributes, Defects, etc.)"
  task clear_seeds: :environment do
    puts "Cleaning up BESM reference data..."

    models = [
      BesmAttribute,
      BesmDefect,
      AttributeEnhancement,
      AttributeLimiter,
      WeaponEnhancement,
      WeaponLimiter
    ]

    models.each do |model|
      count = model.count
      if count > 0
        puts "Deleting #{count} records from #{model.name}..."
        model.delete_all
      end
    end

    puts "BESM reference data cleanup complete!"
  end
end
