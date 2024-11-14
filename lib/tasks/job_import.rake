namespace :job do
  desc "Import data jobs and companies"
  task :import, [ :filename ] => :environment do |t, args|
    require "csv"
    csv_path = Rails.root.join("lib", "assets", args[:filename] || "data.csv")
    CSV.foreach(csv_path, headers: true, col_sep: ";") do |row|
      begin
        company = Company.find_or_create_by!(name: row["company_name"])
        job = Job.create!(
          title: row["title"],
          company: company,
          job_type: row["job_type"].to_i,
          description: row["description"],
        )
        location = Location.find_or_create_by!(
          province: row["province"],
          district: row["district"],
          street: row["street"],
        )
        job.locations << location unless job.locations.include?(location)
        puts "Imported job: #{job.title}, company: #{company.name}"
      rescue StandardError => e
        puts "Error importing row #{row}: #{e.message}"
      end
    end
    puts "Jobs and companies imported successfully!"
  end
end
