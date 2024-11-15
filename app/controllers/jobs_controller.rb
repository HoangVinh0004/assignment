class JobsController < ApplicationController
  def index
    @job_types = Job.job_types.keys
    @locations = Location.distinct.pluck(:province)
    puts "title : #{params[:title]}  =  type : #{params[:job_type]}"
    @jobs = Job.search(params[:title], params[:job_type], params[:location], true)
               .paginate(page: params[:page], per_page: Admin::JobsController::DEFAULT_JOB_PER_PAGE)
  end

  def show
    @job = Job.includes(:company, :locations).find(params[:id])
    @job_application = JobApplication.new
  end
end
