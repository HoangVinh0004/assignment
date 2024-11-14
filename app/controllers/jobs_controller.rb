class JobsController < ApplicationController
  def index
    @job_types = Job.job_types.keys
    puts "title : #{params[:title]}  =  type : #{params[:job_type]}"
    @jobs = Job.search(params[:title], params[:job_type], true).includes(:company, :locations)
               .paginate(page: params[:page], per_page: 3)
  end

  def show
    @job = Job.find(params[:id])
    @job_application = JobApplication.new
  end
end
