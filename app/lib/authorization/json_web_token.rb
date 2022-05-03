# frozen_string_literal: true

module Authorization
  class JsonWebToken
    def self.encode(payload)
      now = Time.current
      payload[:exp] = (now + 6.months).to_i
      payload[:created_at] = now
      JWT.encode(payload, jwt_secret)
    end

    def self.decode(token)
      JWT.decode(token, jwt_secret)
         .first
         .symbolize_keys
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end

    def self.jwt_secret
      Rails.application.credentials.dig(Rails.env.to_sym, :jwt_secret)
    end
  end
end
