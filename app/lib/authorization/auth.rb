# frozen_string_literal: true

module Authorization
  class Auth < ::Monads
    def call(headers)
      token = yield fetch_authorization_token(headers)
      decoded_token = yield decode_authorization_token(token)
      yield validate_current_user_data(decoded_token)
    end

    def fetch_authorization_token(headers)
      token = headers["Authorization"]
      token.present? ? Success(token) : Failure()
    end

    def decode_authorization_token(token)
      decoded_token = ::Authorization::JsonWebToken.decode(token.split.last)
      decoded_token ? Success(decoded_token) : Failure()
    end

    def validate_current_user_data(decoded_token)
      user_id = decoded_token[:id]

      return Failure() unless user_id

      Success(decoded_token)
    end
  end
end
