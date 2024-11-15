require "csv"

class Admin::JobsController < ApplicationController
  DEFAULT_JOB_PER_PAGE = 10
  before_action :admin_user

  def index
    @job_types = Job.job_types.keys
    @locations = Location.distinct.pluck(:province)
    @jobs = Job.search(params[:title], params[:job_type], params[:location], false)
               .paginate(page: params[:page], per_page: DEFAULT_JOB_PER_PAGE)
  end

  def publish
    @job = Job.find(params[:id])
    if @job.update(publish: true)
      flash[:success] = "Job has been published successfully."
    else
      flash[:danger] = "Job has been published failed."
    end
    redirect_to admin_jobs_path
  end

  def upload; end

  def import
    file = params[:file]
    return redirect_to(upload_admin_jobs_path, flash: { danger: "Please select a CSV file to upload." }) if file.nil?

    importer = ImportJobs.new(file.path)
    importer.import
    if importer.success?
      flash[:success] = "Jobs imported successfully! Imported #{importer.success_count} rows"
    else
      flash[:danger] = "Cannot import!!! Unexpected error: #{importer.error_messages.join(", ")}"
    end
    redirect_to upload_admin_jobs_path
  end

  private

  def admin_user
    redirect_to(root_url) unless admin?
  end
end
