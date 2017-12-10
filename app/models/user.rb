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

  def admin?
    role == ADMIN_ROLE
  end
end
