# frozen_string_literal: true

module Authorization
  class Auth < ::Monads
    def call(headers)
      token = yield fetch_authorization_token(headers)
      decoded_token = yield decode_authorization_token(token)
      yield validate_current_user_data(decoded_token)

      Success(decoded_token)
    end

    def fetch_authorization_token(headers)
      token = headers["Authorization"]
      token.present? ? Success(token) : Failure[__method__, { token: "Missing token" }]
    end

    def decode_authorization_token(token)
      decoded_token = ::Authorization::JsonWebToken.decode(token)
      decoded_token ? Success(decoded_token) : Failure[__method__, { token: "Invalid token" }]
    end

    def validate_current_user_data(decoded_token)
      user_id = decoded_token[:id]

      return Failure[__method__, { token: "Invalid token" }] unless user_id

      Success()
    end
  end
end
