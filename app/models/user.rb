class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :password_digest, presence: true

  def self.authenticate_with_credentials(email, password)
   User.find_by(email: email.strip.downcase).try(:authenticate, password)
  end

end
