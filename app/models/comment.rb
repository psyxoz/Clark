class Comment < ApplicationRecord
  include Ownerable
  belongs_to :article

  validates :content, presence: true
end
