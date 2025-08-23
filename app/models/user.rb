class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :role, presence: true, inclusion: { in: %w[user admin] }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :events, dependent: :destroy
end
