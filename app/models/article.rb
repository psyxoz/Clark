class Article < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, :content, presence: true

  def owner
    user.email
  end
end
