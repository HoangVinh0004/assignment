class Job < ApplicationRecord
  # Constants
  JOB_TYPES = [ "full_time", "part_time", "freelance" ].freeze

  # Associations
  belongs_to :company, optional: true

  validates :title, presence: true, length: { maximum: 200 }
  validates :company_name, presence: true
  validates :location, presence: true
  validates :job_type, presence: true
  validates :description, presence: true

  def self.search(title, job_type)
    results = Job.all
    results = results.where("title LIKE ?", "%#{title}%") if title.present?
    results = results.where(job_type: job_type) if job_type.present?
    results
  end
end
