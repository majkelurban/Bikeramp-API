# frozen_string_literal: true

require "dry/monads"

class Monads
  include Dry::Monads[:result, :do]
  include ApiError

  def initialize(params = nil, current_user = nil)
    @params = params
    @current_user = current_user
  end

  private

  attr_reader :params, :current_user
end
