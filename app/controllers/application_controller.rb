# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Dry::Monads[:result]

  before_action :authorize_request

  def authorize_request
    case Authorization::Auth.new.call(request.headers)
    in Success(token)
      @current_user = User.find_by(id: token[:id])
    in [*, error]
      render json: { errors: error }, status: :unauthorized
    end
  end

  attr_reader :current_user
end
