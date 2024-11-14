require "csv"

class Admin::JobsController < ApplicationController
  before_action :admin_user

  def index
    @job_types = Job.job_types.keys
    puts "title : #{params[:title]}  =  type : #{params[:job_type]}"
    @jobs = Job.search(params[:title], params[:job_type], false).includes(:company).paginate(page: params[:page], per_page: 8)
  end

  def publish
    @job = Job.find(params[:id])
    if @job.update(publish: true)
      flash[:success] = "Job has been published successfully."
    else
      flash[:denger] = "Job has been published failed."
    end
    redirect_to admin_jobs_path
  end

  def upload
  end

  def import
    file = params[:file]
    return redirect_to(upload_admin_jobs_path, flash: { danger: "Please select a CSV file to upload." }) if file.nil?

    begin
      CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
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
        puts "Imported job: #{job.title}, company: #{company.name}"
      end
      flash[:success] = "Jobs imported successfully!"
      redirect_to admin_jobs_path
    rescue StandardError => e
      flash[:danger] = "Cannot import!!! Unexpected error: #{e.message}"
      redirect_to(upload_admin_jobs_path)
    end
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
