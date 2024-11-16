require "csv"

class ImportJobs
  attr_reader :file_path, :success_count, :error_messages

  def initialize(file_path)
    @file_path = file_path
    @success_count = 0
    @error_messages = []
  end

  def import
    companies = []
    jobs = []
    locations = []
    job_locations = []
    begin
      CSV.foreach(@file_path, headers: true, col_sep: ";") do |row|
        next if row["company_name"].nil? || row["title"].nil? || row["job_type"].nil?
        # Need to get compamy.id
        company = Company.find_or_create_by!(name: row["company_name"].strip)
        # Add hash to array jobs and locations
        job = {
          title: row["title"].strip,
          company_id: company.id,
          job_type: row["job_type"].to_i,
          description: row["description"].to_s.strip
        }
        jobs << job
        location = {
          province: row["province"].to_s.strip,
          district: row["district"].to_s.strip,
          street: row["street"].to_s.strip
        }
        locations << location unless locations.include?(location)
        job_locations << { job_title: row["title"].strip, location: location }
        @success_count += 1
      end
      # use activaterecord-import
      Company.import(companies)
      Job.import(jobs)
      # Delete duplicate location
      locations = locations.uniq { |l| "#{l[:province]}|#{l[:district]}|#{l[:street]}" }
      Location.import(locations)
      # create association
      job_locations.each do |job_location|
        job = Job.find_by!(title: job_location[:job_title])
        location = Location.find_by!(
          province: job_location[:location][:province],
          district: job_location[:location][:district],
          street: job_location[:location][:street],
        )
        job.locations << location unless job.locations.include?(location)
      end
    rescue StandardError => e
      @error_messages << "Error: #{e.message}"
    end
  end

  def success?
    error_messages.empty?
  end
end
