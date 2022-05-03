# frozen_string_literal: true

module Api
  module V1
    class TripsController < ApplicationController
      def create
        case ::Trips::UseCases::Create.new(params, current_user).call
        in Success()
          head :created
        in :validate, error
          render json: { errors: error }, status: :unprocessable_entity
        end
      end
    end
  end
end
