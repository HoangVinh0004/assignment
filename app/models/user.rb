class User < ApplicationRecord
  MIN_PASSWORD_LENGTH = 6
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: MIN_PASSWORD_LENGTH }
  has_secure_password

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
end
