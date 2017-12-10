class User < ApplicationRecord
  ROLES = [
    ADMIN_ROLE = 'admin'.freeze,
    DEFAULT_ROLE = 'default'.freeze
  ]

  has_secure_password
  has_many :articles
  has_many :comments

  validates :role, inclusion: ROLES
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 6 }, if: -> { password_changed? }

  def admin?
    role == ADMIN_ROLE
  end
end
