class Company < ApplicationRecord
  # Associations
  # has_many :jobs, dependent: :destroy

  validates :name, presence: true
end
