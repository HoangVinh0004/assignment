class Admin::JobsController < ApplicationController
  before_action :admin_user

  def index
    @job_types = Job.job_types.keys
    puts "title : #{params[:title]}  =  type : #{params[:job_type]}"
    @jobs = Job.search(params[:title], params[:job_type], false).includes(:company).paginate(page: params[:page], per_page: 3)
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

  def import
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
