class Job < ApplicationRecord
  enum :job_type, { full_time: 1, part_time: 2, freelance: 3 }
  # Associations
  belongs_to :company
  has_and_belongs_to_many :locations
  has_many :job_applications

  validates :title, presence: true, length: { maximum: 200 }
  validates :company_id, presence: true
  validates :job_type, inclusion: { in: job_types.keys }
  validates :description, presence: true

  def self.search(title, job_type)
    results = Job.all
    results = results.where("title LIKE ?", "%#{title}%") if title.present?
    results = results.where(job_type: job_type) if job_type.present?
    results
  end
end
