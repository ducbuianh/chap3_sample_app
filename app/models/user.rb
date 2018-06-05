class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { 
                                      maximum: Constants::USERNAME_MAX_LENGTH }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 
                                                   Constants::EMAIL_MAX_LENGTH },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
