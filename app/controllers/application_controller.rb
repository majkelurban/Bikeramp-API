# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  protected

  def authorize_request
    render json: {}, status: :unauthorized unless current_user
  end

  def current_user
    return nil unless current_user_data

    @current_user ||= User.find_by(id: current_user_data[:id])
  end

  def current_user_data
    @current_user_data ||= Authorization::Auth.new.call(request.headers).success
  end
end
