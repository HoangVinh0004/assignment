namespace :job do
  desc "Import data jobs and companies"
  task :import, [ :filename ] => :environment do |t, args|
    csv_path = Rails.root.join("lib", "assets", args[:filename] || "data.csv")
    importer = ImportJobs.new(csv_path)
    importer.import
    if importer.success?
      puts "Jobs and companies imported successfully! Imported #{importer.success_count} rows"
    else
      puts "Import failed! Errors: #{importer.error_messages.join(", ")}"
    end
  end
end
