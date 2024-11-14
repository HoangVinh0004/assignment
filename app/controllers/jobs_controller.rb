class JobsController < ApplicationController
  def index
    @job_types = Job::JOB_TYPES
    puts " title : #{params[:title]}  =  type : #{params[:title]}"
    @jobs = Job.search(params[:title], params[:job_type]).paginate(page: params[:page], per_page: 3)
  end

  def show
    @job = Job.find(params[:id])
  end

  def apply
    @job = Job.find(params[:id])
    email = params[:email]
    if email.present?
      UserMailer.apply_job(@job, email).deliver_now
      flash[:success] = "Application sent to #{email}!"
    else
      flash[:danger] = "Please enter a valid email address."
    end
    redirect_to @job
  end
end
