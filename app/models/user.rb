class User < ApplicationRecord
  has_secure_password :password, validations: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase) 

    if user && user.authenticate(password)
      user
    else
      nil
    end

  end

end
