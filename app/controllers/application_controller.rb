class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods,
          ActionView::Rendering,
          HandleErrors

  before_action :set_default_response_format

  protected

  def set_default_response_format
    request.format = :json
  end

  def current_user
    @current_user ||= authenticate_user || raise(CanCan::AccessDenied)
  end

  def authenticate_user
    authenticate_with_http_basic do |email, password|
      User.find_by(email: email)&.authenticate(password)
    end
  end
end
