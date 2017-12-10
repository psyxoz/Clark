class Article < ApplicationRecord
  include Ownerable
  has_many :comments

  validates :title, :content, presence: true
end
