class JsonWebToken
  # set up secret key
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  # encode to form payload
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  # method to decode token
  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body

  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end