# app/controllers/job_applications_controller.rb
class JobApplicationsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @job_application = @job.job_applications.build(job_application_params)
    if @job_application.save
      UserMailer.apply_job(@job, @job_application.email).deliver_now
      flash[:success] = "Application submitted successfully!"
    else
      flash[:error] = "Failed to submit application. Please try again."
    end
    redirect_to request.referrer
  end

  private

  def job_application_params
    params.require(:job_application).permit(:email, :name, :dob, :gender, :description)
  end
end
