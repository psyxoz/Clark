module Common
  extend ActiveSupport::Concern

  included do
    before_action :check_permissions, except: [:index, :show]
    expose(:page) { (params[:page].presence || 1).to_i }
  end
end
