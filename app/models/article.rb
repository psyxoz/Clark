class Article < ApplicationRecord
  include Ownerable
  has_many :comments

  enum status: [:active, :archived]
  scope :active_with_users, -> { active.includes(:user) }

  validates :title, :content, presence: true
end
