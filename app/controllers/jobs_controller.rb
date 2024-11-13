class JobsController < ApplicationController
  def index
    @job_types = Job::JOB_TYPES
    puts " title : #{params[:title]}  =  type : #{params[:title]}"
    @jobs = Job.search(params[:title], params[:job_type])
  end

  def show
    @job = Job.find(params[:id])
  end
end
