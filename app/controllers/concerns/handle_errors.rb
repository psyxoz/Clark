module HandleErrors
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing do |e|
      render_errors(messages: [e.message], status: :bad_request) # 400
    end

    rescue_from CanCan::AccessDenied do |e|
      render_errors(messages: [e.message], status: :forbidden) # 403
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_errors(messages: [e.message], status: :not_found) # 404
    end

    rescue_from ActiveRecord::RecordInvalid,
                ActiveRecord::RecordNotUnique,
                ActiveRecord::RecordNotDestroyed do |e|
      render_errors(messages: [e.message], status: :unprocessable_entity) # 422
    end

    protected

    def render_errors(messages:, status:)
      render 'v1/error', locals: { errors: messages }, status: status
    end
  end
end
