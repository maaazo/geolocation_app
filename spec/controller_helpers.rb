def authenticate_request(payload)
  request.headers["Authorization"] = 
    JWT.encode(payload, JsonWebToken::SECRET_KEY)
end
