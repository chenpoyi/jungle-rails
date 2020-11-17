class User < ActiveRecord::Base
  has_secure_password
  before_validation :normalize_email
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$\z/i, message:  "Email must be a valid format." }
  validates :password, presence: true, length: {minimum: 6, too_short: "Password must be at least 6 characters."}
  validates :password_confirmation, presence: true
  # validate :check_email_format


  private
  def normalize_email
    email.to_s.downcase!
  end

 

end

