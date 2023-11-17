# frozen_string_literal: true

# JsonWebToken handles encoding and decoding JWTs using Rails application credentials as the secret key.
class JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  def self.encode(payload, exp = 60.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
