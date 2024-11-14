class JobApplication < ApplicationRecord
  enum :gender, { male: 1, female: 2, other: 3 }
  belongs_to :job

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :dob, presence: true
  validates :gender, inclusion: { in: genders.keys }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
