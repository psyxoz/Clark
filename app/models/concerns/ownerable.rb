module Ownerable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
  end

  def owner
    user.email
  end
end
