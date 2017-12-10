class ApplicationController < ActionController::API
  include ActionView::Layouts
  include HandleErrors

  before_action :set_default_response_format

  protected

  def set_default_response_format
    #request.format = :json
  end

  def current_user
    @current_user ||= authenticate_with_http_basic do |email, password|
      User.find_by!(email: email).authenticate(password)
    end
  end
end
