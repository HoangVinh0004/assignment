class UserMailer < ApplicationMailer
  def apply_job(job, user_email)
    @job = job
    mail to: user_email, subject: "Application Received for Job - #{@job.title}"
  end
end
