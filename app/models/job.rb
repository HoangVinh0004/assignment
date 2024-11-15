class Job < ApplicationRecord
  MAX_TITLE_LENGTH = 200
  enum :job_type, { full_time: 1, part_time: 2, freelance: 3 }
  # Associations
  belongs_to :company
  has_and_belongs_to_many :locations
  has_many :job_applications

  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :company_id, presence: true
  validates :job_type, inclusion: { in: job_types.keys }
  validates :description, presence: true

  def self.search(title, job_type, province, not_admin)
    results = Job.includes(:company, :locations)
    results = results.where(publish: true) if not_admin
    results = results.where(job_type: job_type) if job_type.present?
    results = results.left_joins(:locations).where(locations: { province: province }) if province.present?
    results = results.where("title LIKE ?", "%" + results.sanitize_sql_like(title) + "%") if title.present?
    results
  end
end
