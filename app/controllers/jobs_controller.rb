class JobsController < ApplicationController
  def index
    @job_types = Job::JOB_TYPES
    puts " title : #{params[:title]}  =  type : #{params[:title]}"
    @jobs = Job.search(params[:title], params[:job_type])
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
      respond_to do |format|
        format.html { redirect_to @job }
        format.js
      end
    else
      flash[:danger] = "Please enter a valid email address."
      respond_to do |format|
        format.html { redirect_to @job }
        format.js
      end
    end
  end
end
