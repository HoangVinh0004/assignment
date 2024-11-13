namespace :job do
  desc "Import data jobs and companies"
  task :import, [ :filename ] => :environment do |t, args|
    require "csv"
    csv_path = Rails.root.join("lib", "assets", args[:filename] || "data.csv")
    CSV.foreach(csv_path, headers: true, col_sep: ";") do |row|
      Company.create!(name: row["company_name"])
      Job.create!(
        title: row["title"],
        company_name: row["company_name"],
        location: row["location"],
        job_type: row["job_type"],
        description: row["description"]
      )
    end
    puts "Jobs and companies imported successfully"
  end
end
