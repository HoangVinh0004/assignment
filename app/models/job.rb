class Job < ApplicationRecord
  # Constants
  JOB_TYPES = [ "full-time", "part-time", "freelance" ].freeze

  # Associations
  belongs_to :company, optional: true

  validates :title, presence: true, length: { maximun: 200 }
  validates :company_name, presence: true
  validates :location, presence: true
  validates :job_type, presence: true
  validates :description, presence: true
end
