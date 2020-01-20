class Comment < ApplicationRecord
  include Ownerable
  belongs_to :article, counter_cache: true

  validates :content, presence: true
end
