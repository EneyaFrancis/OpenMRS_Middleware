# JWT middleware for decoding and validating incoming tokens
class JwtAuth
  def initialize(app)
    @app = app
  end

  def call(env)
    # Extract the Authorization header(e.g "Bearer <token>")
    auth_header = env["HTTP_AUTHORIZATION"]
    token = auth_header&.split(" ")&.last

    begin
      # Decode the JWT using shared secret and HS256(a symmetric,
      # keyed hashing algorithm used for signing and verifying JSON Web Tokens (JWTs))
      payload, = JWT.decode(token, JWT_SECRET, true, algorithm: "HS256")

      # Attach the decoded payload to the environment for downstream use
      env["jwt.payload"] = payload
    rescue JWT::DecodeError => e
      # Invalid or missing token - respond with 401 Unauthorized
      return [
        401,
        { "Content-Type" => "application/json" },
        [{ error: "Invalid or missing token", code: 401 }.to_json]
      ]
    end
    @app.call(env)
  end
end
