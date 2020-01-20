module CustomHelpers
  def parsed_body
    @parsed_body ||= parsed_body_nocache
  end

  def parsed_body_nocache
    JSON.parse(response.body)
  end

  def encode_credentials(user)
    ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
  end
end
