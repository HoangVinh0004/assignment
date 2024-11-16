class Location < ApplicationRecord
  has_and_belongs_to_many :jobs
  validates :province, :district, :street, presence: true
end
