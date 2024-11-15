require "csv"

class ImportJobs
  attr_reader :file_path, :success_count, :error_messages

  def initialize(file_path)
    @file_path = file_path
    @success_count = 0
    @error_messages = []
  end

  def import
    begin
      CSV.foreach(@file_path, headers: true, col_sep: ";") do |row|
        next if row["company_name"].nil? || row["title"].nil? || row["job_type"].nil?
        company = Company.find_or_create_by!(name: row["company_name"].strip)
        job = Job.create!(
          title: row["title"].strip,
          company: company,
          job_type: row["job_type"].to_i,
          description: row["description"].to_s.strip,
        )
        location = Location.find_or_create_by!(
          province: row["province"].to_s.strip,
          district: row["district"].to_s.strip,
          street: row["street"].to_s.strip,
        )
        job.locations << location unless job.locations.include?(location)
        @success_count += 1
      end
    rescue StandardError => e
      @error_messages << "Error: #{e.message}"
    end
  end

  def success?
    error_messages.empty?
  end
end
